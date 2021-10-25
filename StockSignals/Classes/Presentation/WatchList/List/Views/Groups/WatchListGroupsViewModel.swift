//
//  WatchListGroupsViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 23.10.2021.
//

import RxSwift
import RxCocoa

final class WatchListGroupsViewModel {
    lazy var elements = makeElements()
    
    private lazy var watchListManager = WatchListManagerCore()
}

// MARK: Private
private extension WatchListGroupsViewModel {
    func makeElements() -> Driver<[WatchListGroupsCollectionElement]> {
        watchListManager
            .obtainGroups()
            .map { groups -> [WatchListGroupsCollectionElement] in
                groups.map { WatchListGroupsCollectionElement.group($0) } + [.create]
            }
            .asDriver(onErrorJustReturn: [])
    }
}
