//
//  Mover.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 26.11.2021.
//

struct Mover {
    let title: String
    let symbol: String
    let change: Double
}

// MARK: Codable
extension Mover: Codable {}

// MARK: Hashable
extension Mover: Hashable {}
