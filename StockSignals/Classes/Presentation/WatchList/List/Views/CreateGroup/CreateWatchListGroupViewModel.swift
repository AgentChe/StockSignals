//
//  CreateWatchListGroupViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 24.10.2021.
//

import RxSwift
import RxCocoa

final class CreateWatchListGroupViewModel {
    enum Result {
        case group(WatchListGroup)
        case paygate
    }
    
    lazy var create = PublishRelay<String>()
    
    lazy var group = makeGroup()
    
    private lazy var watchListManager = WatchListManagerCore()
    private lazy var sessionManager = SessionManagerCore()
    private lazy var paygateManager = PaygateManagerCore()
}

// MARK: Private
private extension CreateWatchListGroupViewModel {
    func makeGroup() -> Driver<Result> {
        create.flatMapLatest { [weak self] name -> Single<Result> in
            guard let self = self else {
                return .never()
            }
            
            return self.watchListManager
                .obtainGroups()
                .map { $0.count }
                .flatMap { currentCount -> Single<Result> in
                    if self.needPayment(currentCount: currentCount) {
                        return .deferred { .just(.paygate) }
                    }
                    
                    return self.watchListManager
                        .createGroup(name: name, symbols: [])
                        .map { .group($0) }
                }
        }
        .asDriver(onErrorDriveWith: .never())
    }
    
    func needPayment(currentCount: Int) -> Bool {
        let config = paygateManager.getConfig() ?? PaygateConfig.default()
        
        let activeSubscription = sessionManager.getSession()?.activeSubscription ?? false
        
        let needPayment = activeSubscription ? false : (currentCount >= config.watchListLimit)
        
        return needPayment
    }
}
