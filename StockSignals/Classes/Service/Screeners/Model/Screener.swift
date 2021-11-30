//
//  Screener.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 26.11.2021.
//

struct Screener {
    let key: String
    let value: String
    let quotations: [Quotation]
}

// MARK: Codable
extension Screener: Codable {}

// MARK: Hashable
extension Screener: Hashable {}
