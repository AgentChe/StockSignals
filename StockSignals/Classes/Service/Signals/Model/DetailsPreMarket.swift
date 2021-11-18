//
//  DetailsPreMarket.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 18.11.2021.
//

struct DetailsPreMarket {
    enum DeltaIndicator: String, Codable {
        case up, down
    }
    
    let price: Double
    let netChange: Double
    let percentChange: String
    let deltaIndicator: DeltaIndicator?
}

// MARK: Codable
extension DetailsPreMarket: Codable {}

// MARK: Hashable
extension DetailsPreMarket: Hashable {}
