//
//  WatchListViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 21.10.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class WatchListViewController: UIViewController {
    lazy var mainView = WatchListView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = WatchListViewModel()
    
    override func loadView() {
        view = mainView
    }
}

// MARK: Make
extension WatchListViewController {
    static func make() -> WatchListViewController {
        let vc = WatchListViewController()
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}
