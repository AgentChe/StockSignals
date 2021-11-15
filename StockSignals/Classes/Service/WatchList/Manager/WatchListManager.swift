//
//  WatchListManager.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 21.10.2021.
//

import RxSwift

protocol WatchListManager {
    func obtainWatchListSignals(symbols: String?) -> Single<[Quotation]>
    
    func obtainGroups() -> Single<[WatchListGroup]>
    func createGroup(name: String, signals: [Quotation]) -> Single<WatchListGroup>
    func add(signal: Quotation, in group: WatchListGroup) -> Single<WatchListGroup>
    func remove(signal: Quotation, from group: WatchListGroup) -> Single<WatchListGroup>
    func remove(group: WatchListGroup) -> Single<WatchListGroup>
}
