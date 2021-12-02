//
//  Filters.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.12.2021.
//

struct Filters {
    let signalFilter: Filter?
    let groups: [FilterGroup]
}

// MARK: Codable
extension Filters: Codable {}

// MARK: Hashable
extension Filters: Hashable {}
