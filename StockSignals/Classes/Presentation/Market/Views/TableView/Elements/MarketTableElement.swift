//
//  MarketTableElement.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.11.2021.
//

import UIKit

enum MarketTableElement {
    case offset(CGFloat)
    case movers([MarketMoversCollectionElement])
    case allScreeners
}
