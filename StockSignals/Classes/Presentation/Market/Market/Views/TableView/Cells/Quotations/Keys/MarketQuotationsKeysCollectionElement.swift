//
//  MarketQuotationsKeysCollectionElement.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 01.12.2021.
//

final class MarketQuotationsKeysCollectionElement {
    let title: String
    let key: String
    var isSelected: Bool
    
    init(title: String, key: String, isSelected: Bool) {
        self.title = title
        self.key = key
        self.isSelected = isSelected
    }
}
