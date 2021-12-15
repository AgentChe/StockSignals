//
//  OnboardingViewModel.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 17.01.2021.
//

import RxSwift
import RxCocoa

final class OnboardingViewModel {
    enum Step {
        case main, paygate
    }
    
    private lazy var sessionManager = SessionManagerCore()
    private lazy var paygateManager = PaygateManagerCore()
    
    func whatNext() -> Step {
        if let session = sessionManager.getSession(), session.activeSubscription {
            return .main
        }
        
        let config = paygateManager.getConfig() ?? PaygateConfig.default()
        
        return config.afterOnboarding ? .paygate : .main
    }
}
