//
//  MarketViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.11.2021.
//

import UIKit
import RxSwift

final class MarketViewController: UIViewController {
    lazy var mainView = MarketView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = MarketViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addFilterActions()
    }
}

// MARK: Make
extension MarketViewController {
    static func make() -> MarketViewController {
        let vc = MarketViewController()
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: Private
private extension MarketViewController {
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
            .subscribe(onNext: { [weak self] filter in
                self?.viewModel.filter.accept(filter)
                self?.mainView.filterView.type = filter
            })
            .disposed(by: disposeBag)
    }
}
