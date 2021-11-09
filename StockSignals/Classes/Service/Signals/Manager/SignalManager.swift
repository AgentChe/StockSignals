//
//  SignalManager.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.11.2021.
//

import RxSwift

protocol SignalManager {
    func obtainStockSignals() -> Single<[StockSignal]>
    func obtainOptionSignals() -> Single<[OptionCryptoSignal]>
    func obtainCryptoSignals() -> Single<[OptionCryptoSignal]>
    func search(name: String) -> Single<SearchResult?>
}
