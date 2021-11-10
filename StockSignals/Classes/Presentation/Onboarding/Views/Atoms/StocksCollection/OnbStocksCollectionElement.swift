//
//  OnbStocksCollectionElement.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 28.10.2021.
//

final class OnbStocksCollectionElement {
    let signal: Quotation
    var isSelected: Bool
    
    init(signal: Quotation, isSelected: Bool) {
        self.signal = signal
        self.isSelected = isSelected
    }
}
