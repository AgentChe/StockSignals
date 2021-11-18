//
//  DetailsAnalyticsRating.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 17.11.2021.
//

struct DetailsAnalyticsRating {
    let value: Int
    let title: String
}

// MARK: Codable
extension DetailsAnalyticsRating: Codable {}

// MARK: Hashable
extension DetailsAnalyticsRating: Hashable {}
