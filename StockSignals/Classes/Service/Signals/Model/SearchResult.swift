//
//  SearchResult.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.11.2021.
//

struct SearchResult {
    let stockSignals: [StockSignal]
    let optionSignals: [OptionCryptoSignal]
    let cryptoSignals: [OptionCryptoSignal]
    let stockQuotations: [Quotation]
    let optionQuotations: [Quotation]
    let cryptoQuotations: [Quotation]
}

// MARK: Codable
extension SearchResult: Codable {}

// MARK: Hashable
extension SearchResult: Hashable {}
