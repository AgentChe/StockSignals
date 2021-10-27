//
//  IndustriesCollectionElement.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 28.10.2021.
//

final class IndustriesCollectionElement {
    let industry: Industry
    var isSelected: Bool
    
    init(industry: Industry, isSelected: Bool) {
        self.industry = industry
        self.isSelected = isSelected
    }
}
