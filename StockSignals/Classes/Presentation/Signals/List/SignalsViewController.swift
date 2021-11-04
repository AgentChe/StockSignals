//
//  SignalsViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.11.2021.
//

import UIKit
import RxSwift

final class SignalsViewController: UIViewController {
    lazy var mainView = SignalsView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = SignalsViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.elements.drive(onNext: { [weak self] elements in
            self?.mainView.tableView.setup(elements: elements)
        })
        .disposed(by: disposeBag)
        
        addFilterActions()
        mainView.tableView.mainDelegate = self
    }
}

// MARK: Make
extension SignalsViewController {
    static func make() -> SignalsViewController {
        let vc = SignalsViewController()
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: SignalsTableViewDelegate
extension SignalsViewController: SignalsTableViewDelegate {
    func signalsTableViewDidSelect(element: SignalsTableElement) {
        switch element {
        case .type(let type):
            break
        case .stock(let signal):
            break
        case .optionCrypto(let signal):
            break
        default:
            break
        }
    }
}

// MARK: Private
private extension SignalsViewController {
    func addFilterActions() {
        Observable
            .merge(
                mainView.filterView.stockButton
                    .rx.tap
                    .map { _ in SignalsFilter.stock },
                
                mainView.filterView.optionButton
                    .rx.tap
                    .map { _ in SignalsFilter.option },
                
                mainView.filterView.cryptoButton
                    .rx.tap
                    .map { _ in SignalsFilter.crypto }
            )
            .startWith(.stock)
            .subscribe(onNext: { [weak self] filter in
                self?.viewModel.filter.accept(filter)
                self?.mainView.filterView.type = filter
            })
            .disposed(by: disposeBag)
    }
}
