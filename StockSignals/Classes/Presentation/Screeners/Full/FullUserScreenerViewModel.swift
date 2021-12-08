//
//  FullUserScreenerViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 07.12.2021.
//

import RxSwift
import RxCocoa

final class FullUserScreenerViewModel {
    lazy var keys = PublishRelay<[String]>()
    lazy var sort = PublishRelay<WatchListSignalsSortElement>()
    lazy var delete = PublishRelay<String>()
    
    lazy var elements = makeElements()
    lazy var deleted = makeDeleted()
    
    private lazy var screenersManager = ScreenersManagerCore()
    private lazy var watchListManager = WatchListManagerCore()
}

// MARK: Private
private extension FullUserScreenerViewModel {
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
    
    func makeDeleted() -> Driver<Void> {
        delete.flatMapLatest { [weak self] id -> Single<Void> in
            guard let self = self else {
                return .never()
            }
            
            return self.screenersManager
                .delete(filterScreenerId: id)
        }
        .asDriver(onErrorDriveWith: .never())
    }
}
