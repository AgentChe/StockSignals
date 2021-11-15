//
//  SignalsTableElement.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.11.2021.
//

enum SignalsTableElement {
    case type(SignalType)
    case stocksCollection([StockSignal])
    case optionsCryptoCollection([OptionCryptoSignal])
}
