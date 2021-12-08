//
//  FullUserScreenerViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 07.12.2021.
//

import UIKit
import RxSwift

final class FullUserScreenerViewController: UIViewController {
    lazy var mainView = FullUserScreenerView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = FullUserScreenerViewModel()
    
    private var userScreener: UserScreener
    
    private init(userScreener: UserScreener) {
        self.userScreener = userScreener
        
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
        
        viewModel.deleted.drive(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        })
        .disposed(by: disposeBag)
        
        editScreenerDidEdited(filterScreener: userScreener.filterScreener)
        
        mainView.titlesView.scrollDelegate = self
        mainView.titlesView.mainDelegate = self
        mainView.tableView.scrollDelegate = self
        
        addMenuItem()
    }
}

// MARK: Make
extension FullUserScreenerViewController {
    static func make(userScreener: UserScreener) -> FullUserScreenerViewController {
        let vc = FullUserScreenerViewController(userScreener: userScreener)
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: EditScreenerViewControllerDelegate
extension FullUserScreenerViewController: EditScreenerViewControllerDelegate {
    func editScreenerDidEdited(filterScreener: FilterScreener) {
        userScreener = UserScreener(filterScreener: filterScreener, quotations: userScreener.quotations)
        
        let keys = userScreener.filterScreener.items.map { $0.key }
        viewModel.keys.accept(keys)
        
        navigationItem.title = filterScreener.name
    }
}

// MARK: WatchListSignalsScrollDelegate
extension FullUserScreenerViewController: WatchListSignalsScrollDelegate {
    func watchListSignalsDidScroll(_ scrollView: UIScrollView) {
        mainView.titlesView.scroll(as: scrollView)
        mainView.tableView.scroll(as: scrollView)
    }
}

// MARK: WatchListSignalsTitlesViewDelegate
extension FullUserScreenerViewController: WatchListSignalsTitlesViewDelegate {
    func watchListDidSelect(sort: WatchListSignalsSortElement) {
        viewModel.sort.accept(sort)
    }
}

// MARK: FullUserScreenerMenuViewControllerDelegate
extension FullUserScreenerViewController: FullUserScreenerMenuViewControllerDelegate {
    func menuControllerDidSelectEdit() {
        let vc = EditScreenerViewController.make(parentVC: self, filterScreener: userScreener.filterScreener)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func menuControllerDidSelectDelete() {
        viewModel.delete.accept(userScreener.filterScreener.id)
    }
}

// MARK: Private
private extension FullUserScreenerViewController {
    func addMenuItem() {
        let item = UIBarButtonItem()
        item.image = UIImage(named: "Screeners.Menu")
        navigationItem.rightBarButtonItem = item
        
        item.rx.tap.subscribe(onNext: { [weak self] in
            let vc = FullUserScreenerMenuViewController.make()
            vc.delegate = self
            self?.present(vc, animated: false)
        })
        .disposed(by: disposeBag)
    }
}
