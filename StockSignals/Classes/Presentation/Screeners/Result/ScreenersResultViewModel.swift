//
//  ScreenersResultViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 04.12.2021.
//

import RxSwift
import RxCocoa

final class ScreenersResultViewModel {
    lazy var keys = PublishRelay<[String]>()
    lazy var sort = PublishRelay<WatchListSignalsSortElement>()
    lazy var create = PublishRelay<FilterScreener>()
    
    lazy var elements = makeElements()
    lazy var created = makeCreated()
    
    private lazy var watchListManager = WatchListManagerCore()
    private lazy var screenersManager = ScreenersManagerCore()
}

// MARK: Private
private extension ScreenersResultViewModel {
    func makeCreated() -> Driver<FilterScreener> {
        create.flatMapLatest { [weak self] filterScreener -> Single<FilterScreener> in
            guard let self = self else {
                return .never()
            }
            
            return self.screenersManager
                .add(filterScreener: filterScreener)
        }
        .asDriver(onErrorDriveWith: .never())
    }
    
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
}
