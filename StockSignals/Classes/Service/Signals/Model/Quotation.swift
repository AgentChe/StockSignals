//
//  Quotation.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.11.2021.
//

struct Quotation {
    let imageUrl: String?
    let symbol: String
    let company: String
    let price: Double
    let change: Double
    let volume: String
    let peRatio: Double?
    let marketCap: String
}

// MARK: Codable
extension Quotation: Codable {}

// MARK: Hashable
extension Quotation: Hashable {}
