//
//  SplashViewController.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 17.01.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class SplashViewController: UIViewController {
    lazy var mainView = SplashView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = SplashViewModel()
    
    private let generateStep: Signal<Void>
    
    private init(generateStep: Signal<Void>) {
        self.generateStep = generateStep
        
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: generate step
        viewModel.step.drive(onNext: { step in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: { [weak self] in
                self?.handle(step: step)
            })
        })
        .disposed(by: disposeBag)
    }
}

// MARK: Make
extension SplashViewController {
    static func make(generateStep: Signal<Void>) -> SplashViewController {
        SplashViewController(generateStep: generateStep)
    }
}

// MARK: Private
private extension SplashViewController {
    func handle(step: SplashViewModel.Step) {
        switch step {
        case .onboarding:
            UIApplication.shared.keyWindow?.rootViewController = OnboardingViewController.make()
        case .main:
            UIApplication.shared.keyWindow?.rootViewController = TabViewController.make()
        }
    }
}
