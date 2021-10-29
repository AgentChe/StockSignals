//
//  ContentManager.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 28.10.2021.
//

import RxSwift

protocol ContentManager: AnyObject {
    func obtainIndustries() -> Single<[Industry]>
    func set(level: Int?,
             assetsSignals: [String]?,
             tradingStyle: String?,
             interested: String?,
             risk: String?,
             industries: [String]?,
             stocks: [String]?) -> Single<Void>
}
