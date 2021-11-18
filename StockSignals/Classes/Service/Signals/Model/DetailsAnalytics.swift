//
//  DetailsAnalytics.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 17.11.2021.
//

struct DetailsAnalytics {
    let averageRating: Double
    let possibleRatings: [DetailsAnalyticsRating]
    let description: String?
}

// MARK: Codable
extension DetailsAnalytics: Codable {}

// MARK: Hashable
extension DetailsAnalytics: Hashable {}
