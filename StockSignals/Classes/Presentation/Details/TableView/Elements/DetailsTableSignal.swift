//
//  DetailsTableSignal.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 16.11.2021.
//

struct DetailsTableSignal {
    let imageUrl: String
    let symbol: String
    let company: String?
    let created: TimeInterval
    let maxGain: Double
    let buy: Double
    let stop: Double?
    let sells: [Double]
    let note: String?
    let type: SignalType
}

// MARK: Make
extension DetailsTableSignal {
    init(stockSignal: StockSignal) {
        imageUrl = stockSignal.imageUrl
        symbol = stockSignal.symbol
        company = stockSignal.company
        created = stockSignal.created
        maxGain = stockSignal.maxGain
        buy = stockSignal.targetBuy
        stop = stockSignal.targetStop
        sells = [stockSignal.targetSell]
        note = stockSignal.note
        type = stockSignal.type
    }
    
    init(optionCryptoSignal: OptionCryptoSignal) {
        imageUrl = optionCryptoSignal.imageUrl
        symbol = optionCryptoSignal.symbol
        company = nil
        created = optionCryptoSignal.created
        maxGain = optionCryptoSignal.maxGain
        buy = optionCryptoSignal.targetBuy
        stop = optionCryptoSignal.targetStop
        sells = optionCryptoSignal.targetSell
        note = optionCryptoSignal.note
        type = optionCryptoSignal.type
    }
}

// MARK: Codable
extension DetailsTableSignal: Codable {}

// MARK: Hashable
extension DetailsTableSignal: Hashable {}
