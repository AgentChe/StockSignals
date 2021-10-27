//
//  ContentStock.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 28.10.2021.
//

struct ContentStock {
    let id: Int
    let imageUrl: String
    let name: String
    let code: String
}

// MARK: Codable
extension ContentStock: Codable {}

// MARK: Hashable
extension ContentStock: Hashable {}
