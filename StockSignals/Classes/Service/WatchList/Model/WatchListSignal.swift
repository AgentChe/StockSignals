//
//  WatchListSignal.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 21.10.2021.
//

struct WatchListSignal {
    let imageUrl: String
    let symbol: String
    let company: String
    let price: Double
    let change: Double
    let volume: String
    let peRatio: Double
    let marketCap: String
}

// MARK: Codable
extension WatchListSignal: Codable {}

// MARK: Hashable
extension WatchListSignal: Hashable {}
