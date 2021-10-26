//
//  OnboardingViewController.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 17.01.2021.
//

import UIKit
import RxSwift

final class OnboardingViewController: UIViewController {
    struct Constants {
        static let wasViewedKey = "onboarding_view_controller_was_viewed_key"
    }
    
    lazy var mainView = OnboardingView(vc: self)
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = OnboardingViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.didFinish = { [weak self] in
            guard let this = self else {
                return
            }
            
            this.markAsViewed()
            
            this.goToNext()
        }
    }
}

// MARK: Make
extension OnboardingViewController {
    static func make() -> OnboardingViewController {
        OnboardingViewController()
    }
}

// MARK: Public
extension OnboardingViewController {
    static func wasViewed() -> Bool {
        UserDefaults.standard.bool(forKey: OnboardingViewController.Constants.wasViewedKey)
    }
}

// MARK: Private
private extension OnboardingViewController {
    func markAsViewed() {
        UserDefaults.standard.setValue(true, forKey: Constants.wasViewedKey)
    }
    
    func goToNext() {
        switch viewModel.whatNext() {
        case .main:
//            UIApplication.shared.keyWindow?.rootViewController = TabController.make()
        break
        }
    }
}
