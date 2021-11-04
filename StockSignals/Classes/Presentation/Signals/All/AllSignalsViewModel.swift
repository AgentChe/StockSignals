//
//  AllSignalsViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 04.11.2021.
//

import RxSwift
import RxCocoa

final class AllSignalsViewModel {
    lazy var sort = BehaviorRelay<AllSignalsSort>(value: .maxGain)
    lazy var stockSignals = BehaviorRelay<[StockSignal]?>(value: nil)
    lazy var optionCryptoSignals = BehaviorRelay<[OptionCryptoSignal]?>(value: nil)
    
    lazy var elements = makeElements()
    
    private lazy var stockElements = makeStockElements()
    private lazy var optionCryptoElements = makeOptionCryptoElements()
    
    private lazy var stockSortedSignals = makeSortedStockSignals()
    private lazy var optionCryptoSortedSignals = makeSortedOptionCryptoSignals()
}

// MARK: Private
private extension AllSignalsViewModel {
    func makeElements() -> Driver<[SignalsTableElement]> {
        Driver
            .combineLatest(stockElements, optionCryptoElements) { $0 + $1 }
    }
    
    func makeStockElements() -> Driver<[SignalsTableElement]> {
        stockSortedSignals
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
        optionCryptoSortedSignals
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
    
    func makeSortedStockSignals() -> Driver<[StockSignal]> {
        let signals = stockSignals.map { $0 ?? [] }.asDriver(onErrorJustReturn: [])
        let sort = sort.asDriver()
        
        return Driver.combineLatest(signals, sort) { signals, sort -> [StockSignal] in
            signals.sorted(by: { first, second -> Bool in
                switch sort {
                case .createdDown:
                    return first.created > second.created
                case .createdUp:
                    return first.created < second.created
                case .maxGain:
                    return first.maxGain < second.maxGain
                case .name:
                    return first.symbol.lowercased() < second.symbol.lowercased()
                }
            })
        }
    }
    
    func makeSortedOptionCryptoSignals() -> Driver<[OptionCryptoSignal]> {
        let signals = optionCryptoSignals.map { $0 ?? [] }.asDriver(onErrorJustReturn: [])
        let sort = sort.asDriver()
        
        return Driver.combineLatest(signals, sort) { signals, sort -> [OptionCryptoSignal] in
            signals.sorted(by: { first, second -> Bool in
                switch sort {
                case .createdDown:
                    return first.created > second.created
                case .createdUp:
                    return first.created < second.created
                case .maxGain:
                    return first.maxGain < second.maxGain
                case .name:
                    return first.symbol.lowercased() < second.symbol.lowercased()
                }
            })
        }
    }
}
