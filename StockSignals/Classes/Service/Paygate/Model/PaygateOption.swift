//
//  PaygateOption.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.12.2021.
//

struct PaygateOption {
    let productId: String
    let title: String
    let caption: String
    let subCaption: String
    let buttonCaption: String
    let buttonSubCaption: String?
}

// MARK: Codable
extension PaygateOption: Codable {}

// MARK: Hashable
extension PaygateOption: Hashable {}
