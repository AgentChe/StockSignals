//
//  FilterGroup.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.12.2021.
//

struct FilterGroup {
    let name: String
    let filters: [Filter]
}

// MARK: Codable
extension FilterGroup: Codable {}

// MARK: Hashable
extension FilterGroup: Hashable {}
