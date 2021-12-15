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
    
    lazy var step = library()
        .andThen(makeStep())
        .asDriver(onErrorDriveWith: .never())
    
    private lazy var paygateManager = PaygateManagerCore()
}

// MARK: Private
private extension SplashViewModel {
    func library() -> Completable {
        paygateManager
            .retrieveConfig(forceUpdate: true)
            .asCompletable()
    }
    
    func makeStep() -> Single<Step> {
        guard OnboardingViewController.wasViewed() else {
            return .deferred { .just(.onboarding) }
        }
        
        return .deferred { .just(.main) }
    }
}
