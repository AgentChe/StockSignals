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
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable
            .merge(
                mainView.modeView.signalsButton.rx.tap
                    .map { WatchListSelectModeView.Mode.signals },
                
                mainView.modeView.groupsButton.rx.tap
                    .map { WatchListSelectModeView.Mode.groups }
            )
            .subscribe(onNext: { [weak self] mode in
                self?.mainView.modeView.mode = mode
                self?.mainView.updateVisible()
            })
            .disposed(by: disposeBag)
        
        mainView.signalsView.viewDidLoad()
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
