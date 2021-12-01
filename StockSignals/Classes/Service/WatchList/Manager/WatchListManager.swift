//
//  WatchListManager.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 21.10.2021.
//

import RxSwift

protocol WatchListManager {
    func obtainWatchListSignals(symbols: String?, keys: [String]?) -> Single<[Quotation]>
    
    func obtainGroups() -> Single<[WatchListGroup]>
    func createGroup(name: String, symbols: [String]) -> Single<WatchListGroup>
    func add(symbol: String, in group: WatchListGroup) -> Single<WatchListGroup>
    func remove(symbol: String, from group: WatchListGroup) -> Single<WatchListGroup>
    func remove(group: WatchListGroup) -> Single<WatchListGroup>
}
