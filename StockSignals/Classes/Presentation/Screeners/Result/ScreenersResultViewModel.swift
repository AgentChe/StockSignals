//
//  ScreenersResultViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 04.12.2021.
//

import RxSwift
import RxCocoa

final class ScreenersResultViewModel {
    enum CreateResult {
        case screener(FilterScreener)
        case paygate
    }
    
    lazy var keys = PublishRelay<[String]>()
    lazy var sort = PublishRelay<WatchListSignalsSortElement>()
    lazy var create = PublishRelay<FilterScreener>()
    lazy var edit = PublishRelay<FilterScreener>()
    
    lazy var elements = makeElements()
    lazy var created = makeCreated()
    lazy var edited = makeEdited()
    
    private lazy var watchListManager = WatchListManagerCore()
    private lazy var screenersManager = ScreenersManagerCore()
    private lazy var sessionManager = SessionManagerCore()
    private lazy var paygateManager = PaygateManagerCore()
}

// MARK: Private
private extension ScreenersResultViewModel {
    func makeElements() -> Driver<[Quotation]> {
        let quotations = keys.flatMapLatest { [weak self] keys -> Single<[Quotation]> in
            guard let self = self else {
                return .never()
            }
            
            return self.watchListManager
                .obtainWatchListSignals(keys: keys)
        }
        .asDriver(onErrorJustReturn: [])
        
        let sortBy = sort
            .startWith(.price)
            .asDriver(onErrorJustReturn: .price)
        
        return Driver.combineLatest(quotations, sortBy) { quotations, sort -> [Quotation] in
            switch sort {
            case .price:
                return quotations.sorted(by: { $0.price > $1.price })
            case .change:
                return quotations.sorted(by: { $0.change > $1.change })
            case .peRatio:
                return quotations.sorted(by: { ($0.peRatio ?? 0) > ($1.peRatio ?? 0) })
            }
        }
    }
    
    func makeCreated() -> Driver<CreateResult> {
        create.flatMapLatest { [weak self] filterScreener -> Single<CreateResult> in
            guard let self = self else {
                return .never()
            }
            
            return self.screenersManager
                .obtainFilterScreeners()
                .map { $0.count }
                .flatMap { currentCount -> Single<CreateResult> in
                    if self.needPayment(currentCount: currentCount) {
                        return .deferred { .just(.paygate) }
                    }
                    
                    return self.screenersManager
                        .add(filterScreener: filterScreener)
                        .map { .screener($0) }
                }
        }
        .asDriver(onErrorDriveWith: .never())
    }
    
    func makeEdited() -> Driver<FilterScreener> {
        edit.flatMapLatest { [weak self] filterScreener -> Single<FilterScreener> in
            guard let self = self else {
                return .never()
            }
            
            return self.screenersManager
                .edit(filterScreener: filterScreener)
        }
        .asDriver(onErrorDriveWith: .never())
    }
    
    func needPayment(currentCount: Int) -> Bool {
        let config = paygateManager.getConfig() ?? PaygateConfig.default()
        
        let activeSubscription = sessionManager.getSession()?.activeSubscription ?? false
        
        let needPayment = activeSubscription ? false : (currentCount >= config.screenerSaveLimit)
        
        return needPayment
    }
}
