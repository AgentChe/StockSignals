//
//  ProductPrice.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.12.2021.
//

import StoreKit

struct ProductPrice {
    let id: String
    let priceLocalized: String
    let priceValue: Double
    let priceLocale: Locale
    let currency: String
}

// MARK: Make
extension ProductPrice {
    init(product: SKProduct) {
        id = product.productIdentifier
        priceLocalized = product.localizedPrice ?? ""
        priceValue = product.price.doubleValue
        priceLocale = product.priceLocale
        currency = product.priceLocale.currencyCode ?? ""
    }
}
