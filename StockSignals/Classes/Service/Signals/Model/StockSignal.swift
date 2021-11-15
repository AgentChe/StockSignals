//
//  StockSignal.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.11.2021.
//

struct StockSignal {
    let imageUrl: String
    let symbol: String
    let company: String
    let maxGain: Double
    let created: TimeInterval
    let type: SignalType
    let risk: String?
    let targetBuy: Double
    let targetSell: Double
    let targetStop: Double?
    let note: String?
}

// MARK: Codable
extension StockSignal: Codable {}

// MARK: Hashable
extension StockSignal: Hashable {}
