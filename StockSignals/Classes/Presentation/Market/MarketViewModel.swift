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
    
    private lazy var screenersManager = ScreenersManagerCore()
}

// MARK: Private
private extension MarketViewModel {
    func makeElements() -> Driver<[MarketTableElement]> {
        screenersManager
        .obtainBundle()
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
            
            return result
        }
        .asDriver(onErrorJustReturn: [])
    }
}
