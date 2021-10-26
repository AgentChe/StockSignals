//
//  SplashViewModel.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 17.01.2021.
//

import RxSwift
import RxCocoa

final class SplashViewModel {
    enum Step {
        case onboarding, main
    }
    
    lazy var step = makeStep()
}

// MARK: Private
private extension SplashViewModel {
    func makeStep() -> Driver<Step> {
        guard OnboardingViewController.wasViewed() else {
            return .deferred { .just(.onboarding) }
        }
        
        return .deferred { .just(.main) }
    }
}
