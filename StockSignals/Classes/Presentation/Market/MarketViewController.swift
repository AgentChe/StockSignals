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
        
        viewModel.elements.drive(onNext: { [weak self] elements in
            self?.mainView.tableView.setup(elements: elements)
        })
        .disposed(by: disposeBag)
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
