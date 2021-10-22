//
//  WatchListSignalsViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 22.10.2021.
//

import RxSwift
import RxCocoa

final class WatchListSignalsViewModel {
    lazy var elements = makeElements()
    
    private lazy var watchListManager = WatchListManagerCore()
}

// MARK: Private
private extension WatchListSignalsViewModel {
    func makeElements() -> Driver<[WatchListSignal]> {
        watchListManager
            .obtainWatchListSignals()
            .asDriver(onErrorJustReturn: [])
    }
}
