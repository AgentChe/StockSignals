//
//  PaygateViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.12.2021.
//

import UIKit
import RxSwift
import RushSDK

final class PaygateViewController: UIViewController {
    enum Result {
        case bought, canceled
    }
    
    lazy var mainView = PaygateView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = PaygateViewModel()
    
    private let complete: ((Result) -> Void)?
    
    private init(complete: ((Result) -> Void)?) {
        self.complete = complete
        
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
        
        mainView.closeButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true) {
                self?.complete?(.canceled)
            }
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
        
        viewModel.activity.drive(onNext: { [weak self] activity in
            self?.preloader(activity: activity)
        })
        .disposed(by: disposeBag)
        
        viewModel.step
            .drive(onNext: { [weak self] step in
                self?.handle(step: step)
            })
            .disposed(by: disposeBag)
        
        mainView.restoreButton.rx.tap
            .bind(to: viewModel.restore)
            .disposed(by: disposeBag)
        
        mainView.purchaseButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.purchaseTapped()
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
    static func make(complete: ((Result) -> Void)? = nil) -> PaygateViewController {
        let vc = PaygateViewController(complete: complete)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

// MARK: Private
private extension PaygateViewController {
    func purchaseTapped() {
        let option = [
            mainView.firstOptionButton,
            mainView.secondOptionButton,
            mainView.thirdOptionButton
        ].first(where: { $0.isSelect })?.option

        guard let option = option else {
            return
        }

        viewModel.buy.accept(option.productId)
    }
    
    func handle(step: PaygateViewModel.Step) {
        switch step {
        case .buyed, .restored:
            dismiss(animated: true) { [weak self] in
                self?.complete?(.bought)
            }
        case .error:
            Toast.notify(with: "Paygate.Error".localized, style: .danger)
        case .canceled:
            break
        }
    }
    
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
    
    func preloader(activity: Bool) {
        activity ? mainView.preloader.startAnimating() : mainView.preloader.stopAnimating()
        
        mainView.purchaseButton.isHidden = activity
        mainView.restoreButton.isHidden = activity
    }
}
