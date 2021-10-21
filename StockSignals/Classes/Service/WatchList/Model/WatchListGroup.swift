//
//  WatchListGroup.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 21.10.2021.
//

struct WatchListGroup {
    let id: String
    let name: String
    let signals: [WatchListSignal]
}

// MARK: Codable
extension WatchListGroup: Codable {}

// MARK: Hashable
extension WatchListGroup: Hashable {}
