//
//  Paygate.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.12.2021.
//

struct Paygate {
    let headlineTop: String
    let headlineBottom: String
    let options: [PaygateOption]
}

// MARK: Codable
extension Paygate: Codable {}

// MARK: Hashable
extension Paygate: Hashable {}
