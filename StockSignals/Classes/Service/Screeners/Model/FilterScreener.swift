//
//  FilterScreener.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 05.12.2021.
//

struct FilterScreener {
    let name: String
    let items: [Filter.Item]
}

// MARK: Codable
extension FilterScreener: Codable {}

// MARK: Hashable
extension FilterScreener: Hashable {}
