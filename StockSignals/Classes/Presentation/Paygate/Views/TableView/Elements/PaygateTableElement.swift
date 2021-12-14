//
//  PaygateTableElement.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 10.12.2021.
//

import Foundation

enum PaygateTableElement {
    case offset(CGFloat)
    case header(PaygateTableHeader)
    case feature(PaygateTableFeature)
    case moreFeatures
}
