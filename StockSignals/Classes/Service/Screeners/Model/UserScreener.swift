//
//  UserScreener.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 06.12.2021.
//

struct UserScreener {
    let name: String
    let quotations: [Quotation]
}

// MARK: Codable
extension UserScreener: Codable {}

// MARK: Hashable
extension UserScreener: Hashable {}
