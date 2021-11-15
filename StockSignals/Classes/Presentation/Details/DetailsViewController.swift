//
//  DetailsViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.11.2021.
//

import UIKit
import RxSwift

final class DetailsViewController: UIViewController {
    lazy var mainView = DetailsView(symbol: symbol)
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = DetailsViewModel(symbol: symbol)
    
    private let symbol: String
    
    private init(symbol: String) {
        self.symbol = symbol
        
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
        
        mainView.backButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        })
        .disposed(by: disposeBag)
        
        viewModel.company.drive(onNext: { [weak self] company in
            self?.mainView.company = company
        })
        .disposed(by: disposeBag)
        
        addFilterAction()
    }
}

// MARK: Make
extension DetailsViewController {
    static func make(symbol: String) -> DetailsViewController {
        let vc = DetailsViewController(symbol: symbol)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

// MARK: Private
private extension DetailsViewController {
    func addFilterAction() {
        Observable
            .merge(
                mainView.filterView.overviewButton.rx.tap
                    .map { DetailsFilter.overview },
                
                mainView.filterView.summaryButton.rx.tap
                    .map { DetailsFilter.summary },
                
                mainView.filterView.aboutCompanyButton.rx.tap
                    .map { DetailsFilter.aboutCompany }
            )
            .startWith(.overview)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] filter in
                self?.mainView.filterView.filter = filter
                self?.viewModel.filter.accept(filter)
            })
            .disposed(by: disposeBag)
    }
}
