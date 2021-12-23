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
    private lazy var sessionManager = SessionManagerCore()
    private lazy var paygateManager = PaygateManagerCore()
    
    private lazy var stockElements = makeStockElements()
    private lazy var optionCryptoElements = makeOptionCryptoElements()

    private lazy var stockSortedSignals = makeSortedStockSignals()
    private lazy var optionCryptoSortedSignals = makeSortedOptionCryptoSignals()
    
    private lazy var stockSignals = makeStockSignals()
    private lazy var optionCryptoSignals = makeOptionCryptoSignals()
    
    private lazy var activeSubscription = makeActiveSubscription()
}

// MARK: Private
private extension AllSignalsViewModel {
    func makeElements() -> Driver<[AllSignalsTableElement]> {
        Driver
            .combineLatest(stockElements, optionCryptoElements) { $0 + $1 }
    }
    
    func makeStockElements() -> Driver<[AllSignalsTableElement]> {
        Driver.combineLatest(stockSortedSignals, activeSubscription) { [weak self] signals, activeSubscription -> [AllSignalsTableElement] in
            guard let self = self else {
                return []
            }
            
            var result = [AllSignalsTableElement]()
            
            let needPayment = self.needPayment(activeSubscription: activeSubscription)
            
            let config = self.paygateManager.getConfig() ?? PaygateConfig.default()
            let limit = config.signalsLimit

            signals.enumerated().forEach { index, signal in
                let element = AllSignalsTableSSignal(signal: signal,
                                                     isLocked: needPayment ? (index + 1 > limit) : false)
                result.append(.stock(element))

                if (signals.count - 1) != index {
                    result.append(.offset(16.scale))
                }
            }

            return result
        }
    }

    func makeOptionCryptoElements() -> Driver<[AllSignalsTableElement]> {
        Driver.combineLatest(optionCryptoSortedSignals, activeSubscription) { [weak self] signals, activeSubscription -> [AllSignalsTableElement] in
            guard let self = self else {
                return []
            }
            
            var result = [AllSignalsTableElement]()
            
            let needPayment = self.needPayment(activeSubscription: activeSubscription)
            
            let config = self.paygateManager.getConfig() ?? PaygateConfig.default()
            let limit = config.signalsLimit
            
            signals.enumerated().forEach { index, signal in
                let element = AllSignalsTableOCSignal(signal: signal,
                                                      isLocked: needPayment ? (index + 1 > limit) : false)
                result.append(.optionCrypto(element))

                if (signals.count - 1) != index {
                    result.append(.offset(16.scale))
                }
            }

            return result
        }
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
    
    func makeActiveSubscription() -> Driver<Bool> {
        let updated = SDKStorage.shared
            .purchaseMediator
            .rxPurchaseMediatorDidValidateReceipt
            .compactMap { $0?.activeSubscription }
            .asDriver(onErrorJustReturn: false)
        
        let initial = Driver<Bool>
            .deferred { [weak self] in
                guard let this = self else {
                    return .never()
                }
                
                let activeSubscription = this.sessionManager.getSession()?.activeSubscription ?? false
                
                return .just(activeSubscription)
            }
        
        return Driver
            .merge(initial, updated)
    }
    
    func needPayment(activeSubscription: Bool) -> Bool {
        guard !activeSubscription else {
            return false
        }
        
        guard let activity = self.activity.value else {
            return false
        }
        
        switch activity {
        case .working, .longTerm:
            return true
        case .closed:
            return false
        }
    }
}
