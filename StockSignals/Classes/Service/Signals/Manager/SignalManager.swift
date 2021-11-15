//
//  SignalManager.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.11.2021.
//

import RxSwift

protocol SignalManager {
    func obtainStockSignals(activity: Int?) -> Single<[StockSignal]>
    func obtainOptionSignals(activity: Int?) -> Single<[OptionCryptoSignal]>
    func obtainCryptoSignals(activity: Int?) -> Single<[OptionCryptoSignal]>
    func search(name: String) -> Single<SearchResult?>
    func obtainDetails(by symbol: String) -> Single<Details?>
}
