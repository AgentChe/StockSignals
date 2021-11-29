//
//  ScreenersBundle.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 26.11.2021.
//

struct ScreenersBundle {
    let movers: [Mover]
    let screeners: [Screener]
}

// MARK: Codable
extension ScreenersBundle: Codable {}

// MARK: Hashable
extension ScreenersBundle: Hashable {}
