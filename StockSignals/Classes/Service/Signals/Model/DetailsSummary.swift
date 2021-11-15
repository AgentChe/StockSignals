//
//  DetailsSummary.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.11.2021.
//

struct DetailsSummary {
    let sector: String?
    let industry: String?
    let previousClose: String?
    let open: String?
    let marketCap: String?
    let beta: String?
    let exDividendDate: String?
    let dividend: String?
    let yield: String?
    let targetEst: String?
    let peRatio: String?
    let peForward: String?
    let volume: String?
    let averageVolume: String?
    let dayRangeHigh: String?
    let dayRangeLow: String?
    let week52RangeHigh: String?
    let week52RangeLow: String?
    let eps: String?
    let bid: String?
    let ask: String?
}

// MARK: Codable
extension DetailsSummary: Codable {}

// MARK: Hashable
extension DetailsSummary: Hashable {}
