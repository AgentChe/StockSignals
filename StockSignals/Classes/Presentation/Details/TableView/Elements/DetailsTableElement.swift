//
//  DetailsTableElement.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.11.2021.
//

import Foundation

enum DetailsTableElement {
    case offset(CGFloat)
    case title(String)
    case primary(DetailsPreMarket)
    case preMarket(DetailsPreMarket)
    case chart(DetailsTableChartCell)
    case analytics(DetailsAnalytics)
    case unlockAnalytics
    case signals([DetailsTableSignal])
    case summary(title: String, value: String)
    case aboutCompany(String)
}
