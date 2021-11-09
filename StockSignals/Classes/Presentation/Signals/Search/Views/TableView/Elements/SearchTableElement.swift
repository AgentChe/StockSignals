//
//  SearchTableElement.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.11.2021.
//

enum SearchTableElement {
    case offset(CGFloat)
    case type(SearchTableTypeElement)
    case stockSignal(StockSignal)
    case optionCryptoSignal(OptionCryptoSignal)
    case quotations([Quotation])
}
