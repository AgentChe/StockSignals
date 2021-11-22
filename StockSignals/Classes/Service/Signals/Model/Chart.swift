//
//  Chart.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 20.11.2021.
//

struct Chart {
    let timestamp: [Double]
    let open: [Double]
    let close: [Double]
    let low: [Double]
    let high: [Double]
    let volume: [Double]
}

// MARK: Codable
extension Chart: Codable {}

// MARK: Hashable
extension Chart: Hashable {}
