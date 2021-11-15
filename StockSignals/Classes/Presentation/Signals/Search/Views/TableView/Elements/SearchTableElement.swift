//
//  SearchTableElement.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.11.2021.
//

enum SearchTableElement {
    case type(SearchTableTypeElement)
    case stockSignals([StockSignal])
    case optionCryptoSignals([OptionCryptoSignal])
    case quotations([Quotation])
}
