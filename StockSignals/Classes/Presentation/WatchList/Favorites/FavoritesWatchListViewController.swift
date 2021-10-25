//
//  FavoritesWatchListViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 25.10.2021.
//

import UIKit
import RxSwift

final class FavoritesWatchListViewController: UIViewController {
    lazy var mainView = FavoritesWatchListView(group: group)
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = FavoritesWatchListViewModel()
    
    private let group: WatchListGroup
    
    private init(group: WatchListGroup) {
        self.group = group
        
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
        
        mainView.titlesView.scrollDelegate = self
        mainView.titlesView.mainDelegate = self
        mainView.tableView.scrollDelegate = self
    }
}

// MARK: Public
extension FavoritesWatchListViewController {
    static func make(group: WatchListGroup) -> FavoritesWatchListViewController {
        let vc = FavoritesWatchListViewController(group: group)
        vc.viewModel.group.accept(group)
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: WatchListSignalsScrollDelegate
extension FavoritesWatchListViewController: WatchListSignalsScrollDelegate {
    func watchListSignalsDidScroll(_ scrollView: UIScrollView) {
        mainView.titlesView.scroll(as: scrollView)
        mainView.tableView.scroll(as: scrollView)
    }
}

// MARK: WatchListSignalsTitlesViewDelegate
extension FavoritesWatchListViewController: WatchListSignalsTitlesViewDelegate {
    func watchListDidSelect(sort: WatchListSignalsSortElement) {
        viewModel.sort.accept(sort)
    }
}
