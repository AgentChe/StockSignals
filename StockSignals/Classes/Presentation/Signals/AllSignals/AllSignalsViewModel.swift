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
    lazy var type = BehaviorRelay<SignalsFilter?>(value: nil)
    lazy var activity = BehaviorRelay<SignalType?>(value: nil)
    
    lazy var elements = makeElements()
    
    private lazy var signalsManager = SignalManagerCore()
    
    private lazy var stockElements = makeStockElements()
    private lazy var optionCryptoElements = makeOptionCryptoElements()

    private lazy var stockSortedSignals = makeSortedStockSignals()
    private lazy var optionCryptoSortedSignals = makeSortedOptionCryptoSignals()
    
    private lazy var stockSignals = makeStockSignals()
    private lazy var optionCryptoSignals = makeOptionCryptoSignals()
}

// MARK: Private
private extension AllSignalsViewModel {
    func makeElements() -> Driver<[AllSignalsTableElement]> {
        Driver
            .combineLatest(stockElements, optionCryptoElements) { $0 + $1 }
    }
    
    func makeStockElements() -> Driver<[AllSignalsTableElement]> {
        stockSortedSignals
            .map { signals -> [AllSignalsTableElement] in
                var result = [AllSignalsTableElement]()

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

    func makeOptionCryptoElements() -> Driver<[AllSignalsTableElement]> {
        optionCryptoSortedSignals
            .map { signals -> [AllSignalsTableElement] in
                var result = [AllSignalsTableElement]()

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
        let signals = stockSignals.asDriver(onErrorJustReturn: [])
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
        let signals = optionCryptoSignals.asDriver(onErrorJustReturn: [])
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
    
    func makeStockSignals() -> Driver<[StockSignal]> {
        Driver
            .combineLatest(type.asDriver(),
                           activity.asDriver())
            .flatMapLatest { [weak self] type, activity -> Driver<[StockSignal]> in
                guard let self = self, type == .stock else {
                    return .just([])
                }
                
                let value = self.activity(at: activity)
                
                return self.signalsManager
                    .obtainStockSignals(activity: value)
                    .asDriver(onErrorJustReturn: [])
            }
    }
    
    func makeOptionCryptoSignals() -> Driver<[OptionCryptoSignal]> {
        Driver
            .combineLatest(type.asDriver(),
                           activity.asDriver())
            .flatMapLatest { [weak self] type, activity -> Driver<[OptionCryptoSignal]> in
                guard let self = self, let type = type else {
                    return .just([])
                }
                
                let value = self.activity(at: activity)
                
                switch type {
                case .stock:
                    return .just([])
                case .option:
                    return self.signalsManager
                        .obtainOptionSignals(activity: value)
                        .asDriver(onErrorJustReturn: [])
                case .crypto:
                    return self.signalsManager
                        .obtainCryptoSignals(activity: value)
                        .asDriver(onErrorJustReturn: [])
                }
            }
    }
    
    func activity(at: SignalType?) -> Int? {
        guard let at = at else {
            return nil
        }
        
        switch at {
        case .working:
            return 1
        case .closed:
            return 0
        case .longTerm:
            return 2
        }
    }
}
