//
//  FavoritesWatchListViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 25.10.2021.
//

import RxSwift
import RxCocoa

final class FavoritesWatchListViewModel {
    lazy var group = BehaviorRelay<WatchListGroup?>(value: nil)
    lazy var sort = PublishRelay<WatchListSignalsSortElement>()
    
    lazy var elements = makeElements()
    
    private lazy var watchListManager = WatchListManagerCore()
}

// MARK: Private
private extension FavoritesWatchListViewModel {
    func makeElements() -> Driver<[Quotation]> {
        let signals = group
            .compactMap { $0?.symbols }
            .flatMapLatest { [weak self] symbols -> Single<[Quotation]> in
                guard let self = self else {
                    return .never()
                }
                
                let string = symbols.joined(separator: ",")
                
                return self.watchListManager
                    .obtainWatchListSignals(symbols: string)
            }
            .asDriver(onErrorJustReturn: [])
        
        let sortBy = sort
            .startWith(.price)
            .asDriver(onErrorJustReturn: .price)
        
        return Driver.combineLatest(signals, sortBy) { signals, sort -> [Quotation] in
            switch sort {
            case .price:
                return signals.sorted(by: { $0.price > $1.price })
            case .change:
                return signals.sorted(by: { $0.change > $1.change })
            case .peRatio:
                return signals.sorted(by: { ($0.peRatio ?? 0) > ($1.peRatio ?? 0) })
            }
        }
    }
}
