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
    case signals([DetailsTableSignal])
    case summary(title: String, value: String)
    case aboutCompany(String)
}
