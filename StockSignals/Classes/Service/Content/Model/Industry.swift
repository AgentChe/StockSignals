//
//  Industry.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 28.10.2021.
//

struct Industry {
    let id: Int
    let name: String
}

// MARK: Codable
extension Industry: Codable {}

// MARK: Hashable
extension Industry: Hashable {}
