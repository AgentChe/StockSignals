//
//  NotificationsViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.10.2021.
//

import UIKit
import RxSwift

final class NotificationsViewController: UIViewController {
    lazy var mainView = NotificationsView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = NotificationsViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.sections.drive(onNext: { [weak self] sections in
            self?.mainView.tableView.setup(sections: sections)
        })
        .disposed(by: disposeBag)
        
        addFilterActions()
    }
}

// MARK: Make
extension NotificationsViewController {
    static func make() -> NotificationsViewController {
        let vc = NotificationsViewController()
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: Private
private extension NotificationsViewController {
    func addFilterActions() {
        Observable
            .merge(
                mainView.filterView.stockButton
                    .rx.tap
                    .map { _ in NotificationType.stock },
                
                mainView.filterView.optionButton
                    .rx.tap
                    .map { _ in NotificationType.option },
                
                mainView.filterView.cryptoButton
                    .rx.tap
                    .map { _ in NotificationType.crypto }
            )
            .startWith(.stock)
            .subscribe(onNext: { [weak self] type in
                self?.viewModel.type.accept(type)
                self?.mainView.filterView.type = type
            })
            .disposed(by: disposeBag)
    }
}
