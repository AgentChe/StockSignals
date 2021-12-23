//
//  ScreenersResultViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 04.12.2021.
//

import UIKit
import RxSwift
import RxCocoa

protocol ScreenersResultViewControllerDelegate: AnyObject {
    func resultViewControllerDidCreated(filterScreener: FilterScreener)
}

final class ScreenersResultViewController: UIViewController {
    enum Mode {
        case create, edit(FilterScreener)
    }
    
    weak var delegate: ScreenersResultViewControllerDelegate?
    
    lazy var mainView = ScreenersResultView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = ScreenersResultViewModel()
    
    private lazy var saveButton = UIBarButtonItem()
    
    private let mode: Mode
    private let items: [Filter.Item]
    
    private init(mode: Mode, items: [Filter.Item]) {
        self.mode = mode
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
            self?.handle(canSave: !elements.isEmpty)
        })
        .disposed(by: disposeBag)
        
        viewModel.created.drive(onNext: { [weak self] result in
            self?.handle(result: result)
        })
        .disposed(by: disposeBag)
        
        viewModel.edited.drive(onNext: { [weak self] filterScreener in
            self?.delegate?.resultViewControllerDidCreated(filterScreener: filterScreener)
        })
        .disposed(by: disposeBag)
        
        let keys = items.map { $0.key }
        viewModel.keys.accept(keys)
        
        mainView.titlesView.scrollDelegate = self
        mainView.titlesView.mainDelegate = self
        mainView.tableView.scrollDelegate = self
        mainView.tableView.mainDelegate = self
        
        addSaveItem()
        handle(canSave: false)
    }
}

// MARK: Make
extension ScreenersResultViewController {
    static func make(mode: Mode, items: [Filter.Item]) -> ScreenersResultViewController {
        let vc = ScreenersResultViewController(mode: mode, items: items)
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

// MARK: WatchListSignalsTableViewDelegate
extension ScreenersResultViewController: WatchListSignalsTableViewDelegate {
    func watchListSignalsDidSelect(quotation: Quotation) {
        let vc = DetailsViewController.make(symbol: quotation.symbol)
        present(vc, animated: true)
    }
}

// MARK: Private
private extension ScreenersResultViewController {
    func addSaveItem() {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 62, green: 89, blue: 223))
            .font(Fonts.SFProDisplay.regular(size: 17.scale))
            .dictionary
        
        saveButton.setTitleTextAttributes(attrs, for: .normal)
        saveButton.title = "CreateScreener.Save".localized
        navigationItem.rightBarButtonItem = saveButton
        
        saveButton.rx.tap.subscribe(onNext: { [weak self] in
            let vc = ScreenerNameViewController.make(name: self?.nameIfHas()) { name in
                self?.createScreener(name: name)
            }
            self?.present(vc, animated: true)
        })
        .disposed(by: disposeBag)
    }
    
    func handle(canSave: Bool) {
        saveButton.isEnabled = canSave
    }
    
    func createScreener(name: String) {
        switch mode {
        case .create:
            let screener = FilterScreener(id: UUID().uuidString, name: name, items: items)
            viewModel.create.accept(screener)
        case .edit(let previous):
            let screener = FilterScreener(id: previous.id, name: name, items: items)
            viewModel.edit.accept(screener)
        }
    }
    
    func handle(result: ScreenersResultViewModel.CreateResult) {
        switch result {
        case .screener(let filterScreener):
            delegate?.resultViewControllerDidCreated(filterScreener: filterScreener)
        case .paygate:
            let vc = PaygateViewController.make()
            present(vc, animated: true)
        }
    }
    
    func nameIfHas() -> String? {
        guard case let .edit(previous) = mode else {
            return nil
        }
        
        return previous.name
    }
}
