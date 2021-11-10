//
//  AllQuotationsViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 10.11.2021.
//

import RxSwift
import RxCocoa

final class AllQuotationsViewModel {
    lazy var quotations = BehaviorRelay<[Quotation]>(value: [])
    lazy var sort = PublishRelay<WatchListSignalsSortElement>()
    
    lazy var elements = makeElements()
}

// MARK: Private
private extension AllQuotationsViewModel {
    func makeElements() -> Driver<[Quotation]> {
        let quotations = quotations.asDriver()
        
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
