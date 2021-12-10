//
//  PaygateManager.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.12.2021.
//

import RxSwift

protocol PaygateManager {
    func obtainPaygateTransfer() -> Single<Paygate?>
    func preparePrices(for transfer: Paygate) -> Single<Paygate?>
}
