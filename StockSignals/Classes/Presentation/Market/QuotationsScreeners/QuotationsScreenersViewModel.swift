//
//  QuotationsScreenersViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 01.12.2021.
//

import RxSwift
import RxCocoa

final class QuotationsScreenersViewModel {
    let didSelect: BehaviorRelay<String?>
    lazy var sort = PublishRelay<WatchListSignalsSortElement>()
    
    let keys: Driver<[MarketQuotationsKeysCollectionElement]>
    lazy var elements = makeElements()
    
    private lazy var quotations = makeQuotations()
    
    private lazy var watchListManager = WatchListManagerCore()
    
    init(keys: [MarketQuotationsKeysCollectionElement]) {
        self.keys = BehaviorRelay(value: keys).asDriver()
        self.didSelect = BehaviorRelay(value: keys.first(where: { $0.isSelected })?.key)
    }
}

// MARK: Private
private extension QuotationsScreenersViewModel {
    func makeElements() -> Driver<[Quotation]> {
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
    
    func makeQuotations() -> Driver<[Quotation]> {
        didSelect
            .compactMap { $0 }
            .flatMapLatest { [weak self] key -> Single<[Quotation]> in
                guard let self = self else {
                    return .never()
                }
            
                return self.watchListManager
                    .obtainWatchListSignals(keys: [key])
                    .catchAndReturn([])
            }
            .asDriver(onErrorJustReturn: [])
    }
}
