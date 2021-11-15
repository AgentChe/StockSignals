//
//  AllSignalsTableElement.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.11.2021.
//

import Foundation

enum AllSignalsTableElement {
    case offset(CGFloat)
    case stock(StockSignal)
    case optionCrypto(OptionCryptoSignal)
}
