//
//  Details.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.11.2021.
//

struct Details {
    let imageUrl: String?
    let symbol: String
    let company: String
    let about: String
    let primary: DetailsPreMarket?
    let preMarket: DetailsPreMarket?
    let analytics: DetailsAnalytics?
    let stockSignals: [StockSignal]
    let optionSignals: [OptionCryptoSignal]
    let summary: DetailsSummary
}

// MARK: Codable
extension Details: Codable {}

// MARK: Hashable
extension Details: Hashable {}
