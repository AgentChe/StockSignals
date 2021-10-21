//
//  WatchListManager.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 21.10.2021.
//

import RxSwift

protocol WatchListManager {
    func obtainWatchListSignals() -> Single<[WatchListSignal]>
    
    func obtainGroups() -> Single<[WatchListGroup]>
    func createGroup(name: String, signals: [WatchListSignal]) -> Single<WatchListGroup>
    func add(signal: WatchListSignal, in group: WatchListGroup) -> Single<WatchListGroup>
    func remove(signal: WatchListSignal, from group: WatchListGroup) -> Single<WatchListGroup>
    func remove(group: WatchListGroup) -> Single<WatchListGroup>
}
