//
//  SignalsTableElement.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.11.2021.
//

enum SignalsTableElement {
    case offset(CGFloat)
    case type(SignalType)
    case stock(StockSignal)
    case optionCrypto(OptionCryptoSignal)
}
