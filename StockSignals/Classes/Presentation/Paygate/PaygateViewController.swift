//
//  PaygateViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.12.2021.
//

import UIKit
import RxSwift

final class PaygateViewController: UIViewController {
    lazy var mainView = PaygateView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = PaygateViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.paygate.drive(onNext: { paygate in
            print()
        })
        .disposed(by: disposeBag)
    }
}

// MARK: Make
extension PaygateViewController {
    static func make() -> PaygateViewController {
        let vc = PaygateViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}
