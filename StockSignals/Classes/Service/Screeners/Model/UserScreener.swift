//
//  UserScreener.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 06.12.2021.
//

struct UserScreener {
    let filterScreener: FilterScreener
    let quotations: [Quotation]
}

// MARK: Codable
extension UserScreener: Codable {}

// MARK: Hashable
extension UserScreener: Hashable {}
