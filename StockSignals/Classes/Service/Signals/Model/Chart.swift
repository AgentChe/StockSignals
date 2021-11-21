//
//  Chart.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 20.11.2021.
//

struct Chart {
    let timestamp: [Int]
    let open: [Double]
    let close: [Double]
    let low: [Double]
    let high: [Double]
    let volume: [Int]
}

// MARK: Codable
extension Chart: Codable {}

// MARK: Hashable
extension Chart: Hashable {}
