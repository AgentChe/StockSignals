//
//  Filter.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.12.2021.
//

struct Filter {
    struct Item: Codable, Hashable {
        let key: String
        let value: String
    }
    
    let title: String
    let items: [Item]
}

// MARK: Codable
extension Filter: Codable {}

// MARK: Hashable
extension Filter: Hashable {}
