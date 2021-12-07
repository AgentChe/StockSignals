//
//  MarketViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.11.2021.
//

import RxSwift
import RxCocoa

final class MarketViewModel {
    lazy var elements = makeElements()
    
    private lazy var filters = makeFilters()
    
    private lazy var screenersManager = ScreenersManagerCore()
}

// MARK: Private
private extension MarketViewModel {
    func makeElements() -> Driver<[MarketTableElement]> {
        filters.flatMapLatest { [weak self] filters -> Driver<ScreenersBundle?> in
            guard let self = self else {
                return .never()
            }
            
            return self.screenersManager
                .obtainBundle(filters: filters)
                .asDriver(onErrorJustReturn: nil)
        }
        .map { bundle -> [MarketTableElement] in
            guard let bundle = bundle else {
                return []
            }
            
            var result = [MarketTableElement]()
            
            if !bundle.movers.isEmpty {
                let elements = bundle.movers.map { MarketMoversCollectionElement(mover: $0) }
                let element = MarketTableElement.movers(elements)
                result.append(element)
            }
            
            result.append(.allScreeners)
            
            if !bundle.screeners.isEmpty {
                let elements = bundle.screeners.enumerated().map { index, screener -> MarketTableQuotationsElement in
                    let key = MarketQuotationsKeysCollectionElement(title: screener.value,
                                                                    key: screener.key,
                                                                    isSelected: index == 0)
                    return MarketTableQuotationsElement(key: key,
                                                        quotations: screener.quotations)
                }
                let element = MarketTableElement.quotations(elements)
                result.append(element)
            }
            
            let userScreeners = bundle.userScreeners.filter { !$0.quotations.isEmpty }
            if !userScreeners.isEmpty {
                result.append(.allUserScreeners)
                let element = MarketTableElement.userScreeners(userScreeners)
                result.append(element)
            }
            
            return result
        }
    }
    
    func makeFilters() -> Driver<[FilterScreener]?> {
        ScreenersMediator.shared
            .changedFiltersScreeners
            .startWith(())
            .flatMapLatest { [weak self] _ -> Driver<[FilterScreener]?> in
                guard let self = self else {
                    return .never()
                }
                
                return self.screenersManager
                    .obtainFilterScreeners()
                    .map { $0.isEmpty ? nil : Array($0.prefix(3)) }
                    .asDriver(onErrorJustReturn: [])
            }
    }
}
