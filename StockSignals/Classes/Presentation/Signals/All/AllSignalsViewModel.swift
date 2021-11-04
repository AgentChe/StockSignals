//
//  AllSignalsViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 04.11.2021.
//

import RxSwift
import RxCocoa

final class AllSignalsViewModel {
    lazy var stockSignals = BehaviorRelay<[StockSignal]?>(value: nil)
    lazy var optionCryptoSignals = BehaviorRelay<[OptionCryptoSignal]?>(value: nil)
    
    lazy var elements = makeElements()
    
    private lazy var stockElements = makeStockElements()
    private lazy var optionCryptoElements = makeOptionCryptoElements()
}

// MARK: Private
private extension AllSignalsViewModel {
    func makeElements() -> Driver<[SignalsTableElement]> {
        Driver
            .combineLatest(stockElements, optionCryptoElements) { $0 + $1 }
    }
    
    func makeStockElements() -> Driver<[SignalsTableElement]> {
        stockSignals
            .map { $0 ?? [] }
            .map { signals -> [SignalsTableElement] in
                var result = [SignalsTableElement]()
                
                signals.enumerated().forEach { index, signal in
                    result.append(.stock(signal))
                    
                    if (signals.count - 1) != index {
                        result.append(.offset(16.scale))
                    }
                }
                
                return result
            }
            .asDriver(onErrorJustReturn: [])
    }
    
    func makeOptionCryptoElements() -> Driver<[SignalsTableElement]> {
        optionCryptoSignals
            .map { $0 ?? [] }
            .map { signals -> [SignalsTableElement] in
                var result = [SignalsTableElement]()
                
                signals.enumerated().forEach { index, signal in
                    result.append(.optionCrypto(signal))
                    
                    if (signals.count - 1) != index {
                        result.append(.offset(16.scale))
                    }
                }
                
                return result
            }
            .asDriver(onErrorJustReturn: [])
    }
}
