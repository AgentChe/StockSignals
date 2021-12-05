//
//  ScreenersResultViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 04.12.2021.
//

import UIKit
import RxSwift

final class ScreenersResultViewController: UIViewController {
    lazy var mainView = ScreenersResultView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = ScreenersResultViewModel()
    
    private let items: [Filter.Item]
    
    private init(items: [Filter.Item]) {
        self.items = items
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.elements.drive(onNext: { [weak self] elements in
            self?.mainView.tableView.setup(elements: elements)
        })
        .disposed(by: disposeBag)
        
        viewModel.created.drive(onNext: { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        })
        .disposed(by: disposeBag)
        
        let keys = items.map { $0.key }
        viewModel.keys.accept(keys)
        
        mainView.titlesView.scrollDelegate = self
        mainView.titlesView.mainDelegate = self
        mainView.tableView.scrollDelegate = self
        
        addSaveItem()
    }
}

// MARK: Make
extension ScreenersResultViewController {
    static func make(items: [Filter.Item]) -> ScreenersResultViewController {
        let vc = ScreenersResultViewController(items: items)
        vc.navigationItem.title = "CreateScreener.Title".localized
        return vc
    }
}

// MARK: WatchListSignalsScrollDelegate
extension ScreenersResultViewController: WatchListSignalsScrollDelegate {
    func watchListSignalsDidScroll(_ scrollView: UIScrollView) {
        mainView.titlesView.scroll(as: scrollView)
        mainView.tableView.scroll(as: scrollView)
    }
}

// MARK: WatchListSignalsTitlesViewDelegate
extension ScreenersResultViewController: WatchListSignalsTitlesViewDelegate {
    func watchListDidSelect(sort: WatchListSignalsSortElement) {
        viewModel.sort.accept(sort)
    }
}

// MARK: Private
private extension ScreenersResultViewController {
    func addSaveItem() {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 62, green: 89, blue: 223))
            .font(Fonts.SFProDisplay.regular(size: 17.scale))
            .dictionary
        
        let item = UIBarButtonItem()
        item.setTitleTextAttributes(attrs, for: .normal)
        item.title = "CreateScreener.Save".localized
        navigationItem.rightBarButtonItem = item
        
        item.rx.tap.subscribe(onNext: { [weak self] in
            let vc = ScreenerNameViewController.make { name in
                self?.createSceener(name: name)
            }
            self?.present(vc, animated: true)
        })
        .disposed(by: disposeBag)
    }
    
    func createSceener(name: String) {
        let screener = FilterScreener(name: name, items: items)
        viewModel.create.accept(screener)
    }
}
