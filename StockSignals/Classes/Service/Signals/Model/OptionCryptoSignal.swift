//
//  OptionCryptoSignal.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.11.2021.
//

struct OptionCryptoSignal {
    let imageUrl: String
    let symbol: String
    let description: String
    let created: TimeInterval
    let type: SignalType
    let maxGain: Double
    let targetBuy: Double
    let targetStop: Double?
    let targetSell: [Double] // от 1 до 3 значений
    let note: String?
}

// MARK: Codable
extension OptionCryptoSignal: Codable {}

// MARK: Hashable
extension OptionCryptoSignal: Hashable {}
