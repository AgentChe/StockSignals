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
        
        mainView.closeButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        })
        .disposed(by: disposeBag)
        
        viewModel.elements.drive(onNext: { [weak self] elements in
            self?.mainView.tableView.setup(elements: elements)
        })
        .disposed(by: disposeBag)
        
        viewModel.options.drive(onNext: { [weak self] options in
            self?.setup(options: options)
        })
        .disposed(by: disposeBag)
        
        Observable
            .merge(
                mainView.termsButton.rx.tap.map { GlobalDefinitions.termsOfServiceUrl },
                mainView.privacyButton.rx.tap.map { GlobalDefinitions.privacyPolicyUrl }
            )
            .subscribe(onNext: { [weak self] path in
                self?.open(path: path)
            })
            .disposed(by: disposeBag)
        
        addOptionsActions()
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

// MARK: Private
private extension PaygateViewController {
    func open(path: String) {
        guard let url = URL(string: path) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:])
    }
    
    func setup(options: [PaygateOption]) {
        if options.indices.contains(0) {
            mainView.firstOptionButton.option = options[0]
        }
        
        if options.indices.contains(1) {
            let option = options[1]
            mainView.secondOptionButton.option = option
            mainView.purchaseButton.setup(top: option.buttonCaption, bottom: option.subCaption)
        }
        
        if options.indices.contains(2) {
            mainView.thirdOptionButton.option = options[2]
        }
        
        mainView.secondOptionButton.isBestValue = true
        mainView.secondOptionButton.isSelect = true
    }
    
    func addOptionsActions() {
        Observable
            .merge(
                mainView.firstOptionButton.rx.tap
                    .map { [weak self] _ -> PaygateOptionView? in
                        self?.mainView.firstOptionButton
                    },
                
                mainView.secondOptionButton.rx.tap
                    .map { [weak self] _ -> PaygateOptionView? in
                        self?.mainView.secondOptionButton
                    },
                
                mainView.thirdOptionButton.rx.tap
                    .map { [weak self] _ -> PaygateOptionView? in
                        self?.mainView.thirdOptionButton
                    }
            )
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] view in
                guard let self = self, let option = view.option else {
                    return
                }
                
                [
                    self.mainView.firstOptionButton,
                    self.mainView.secondOptionButton,
                    self.mainView.thirdOptionButton
                ].forEach { $0.isSelect = false }
                
                view.isSelect = true
                
                self.mainView.purchaseButton.setup(top: option.buttonCaption, bottom: option.buttonSubCaption)
            })
            .disposed(by: disposeBag)
    }
}
