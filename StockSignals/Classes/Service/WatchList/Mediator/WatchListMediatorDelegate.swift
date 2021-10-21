//
//  WatchListMediatorDelegate.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 21.10.2021.
//

protocol WatchListMediatorDelegate: AnyObject {
    func watchListDidCreated(group: WatchListGroup)
    func watchListDidChanged(group: WatchListGroup)
    func watchListDidRemoved(group: WatchListGroup)
}
