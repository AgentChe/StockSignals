//
//  AllSignalsViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 04.11.2021.
//

import UIKit
import RxSwift

final class AllSignalsViewController: UIViewController {
    lazy var mainView = AllSignalsView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = AllSignalsViewModel()
    
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
extension AllSignalsViewController {
    static func make(type: SignalType, stockSignals: [StockSignal]?, optionCryptoSignals: [OptionCryptoSignal]?) -> AllSignalsViewController {
        let vc = AllSignalsViewController()
        vc.navigationItem.backButtonTitle = " "
        
        let title: String
        switch type {
        case .working:
            title = "Signals.OpenSignals".localized
        case .longTerm:
            title = "Signals.LongTermSignals".localized
        case .closed:
            title = "Signals.ClosedSignals".localized
        }
        vc.navigationItem.title = title
        
        vc.viewModel.stockSignals.accept(stockSignals)
        vc.viewModel.optionCryptoSignals.accept(optionCryptoSignals)
        
        return vc
    }
}
