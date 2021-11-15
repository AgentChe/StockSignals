//
//  SignalsViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.11.2021.
//

import RxSwift
import RxCocoa

final class SignalsViewModel {
    lazy var filter = PublishRelay<SignalsFilter>()
    lazy var didSelectAllSignals = PublishRelay<SignalType>()
    
    lazy var elements = makeElements()
    lazy var selectedAllSignals = makeAllSignals()
    
    private lazy var signalManager = SignalManagerCore()
    
    private lazy var selectedGroup = makeSelectedGroup()
    private lazy var groups = makeGroups()
    
    private lazy var stockGroup = makeStockGroup()
    private lazy var optionGroup = makeOptionGroup()
    private lazy var cryptoGroup = makeCryptoGroup()
    
    private lazy var stockSignals = makeStockSignals()
    private lazy var optionSignals = makeOptionSignals()
    private lazy var cryptoSignals = makeCryptoSignals()
}

// MARK: Private
private extension SignalsViewModel {
    func makeAllSignals() -> Driver<SelectedAllSignals> {
        didSelectAllSignals
            .withLatestFrom(filter) { ($0, $1) }
            .flatMapLatest { [weak self] type, filter -> Driver<SelectedAllSignals> in
                guard let self = self else {
                    return .never()
                }
                
                switch filter {
                case .stock:
                    return self.stockSignals
                        .map { signals -> [StockSignal] in
                            signals.filter { $0.type == type }
                        }
                        .map { SelectedAllSignals(type: type, stockSignals: $0, optionCryptoSignals: nil) }
                case .option:
                    return self.optionSignals
                        .map { signals -> [OptionCryptoSignal] in
                            signals.filter { $0.type == type }
                        }
                        .map { SelectedAllSignals(type: type, stockSignals: nil, optionCryptoSignals: $0) }
                case .crypto:
                    return self.cryptoSignals
                        .map { signals -> [OptionCryptoSignal] in
                            signals.filter { $0.type == type }
                        }
                        .map { SelectedAllSignals(type: type, stockSignals: nil, optionCryptoSignals: $0) }
                }
            }
            .asDriver(onErrorDriveWith: .never())
    }
    
    func makeElements() -> Driver<[SignalsTableElement]> {
        selectedGroup.map { $0.elements }
    }
    
    func makeSelectedGroup() -> Driver<SignalsTableGroup> {
        Driver
            .combineLatest(filter.asDriver(onErrorDriveWith: .never()), groups) { filter, groups -> SignalsTableGroup? in
                groups.first(where: { $0.filter == filter })
            }
            .compactMap { $0 }
    }
    
    func makeGroups() -> Driver<[SignalsTableGroup]> {
        Driver
            .combineLatest(stockGroup, optionGroup, cryptoGroup) {
                [$0, $1, $2]
            }
    }
    
    func makeStockGroup() -> Driver<SignalsTableGroup> {
        stockSignals.map { signals -> SignalsTableGroup in
            var elements = [SignalsTableElement]()
            
            let workingSignals = signals.filter { $0.type == .working }
            if !workingSignals.isEmpty, let signal = workingSignals.first {
                elements.append(.type(.working))
                elements.append(.stock(signal))
            }
            
            let longTermSignals = signals.filter { $0.type == .longTerm }
            if !longTermSignals.isEmpty, let signal = longTermSignals.first {
                elements.append(.type(.longTerm))
                elements.append(.stock(signal))
            }
            
            let closedSignals = signals.filter { $0.type == .closed }
            if !closedSignals.isEmpty, let signal = closedSignals.first {
                elements.append(.type(.closed))
                elements.append(.stock(signal))
            }
            
            return SignalsTableGroup(filter: .stock,
                                     elements: elements)
        }
    }
    
    func makeOptionGroup() -> Driver<SignalsTableGroup> {
        optionSignals.map { signals -> SignalsTableGroup in
            var elements = [SignalsTableElement]()
            
            let workingSignals = signals.filter { $0.type == .working }
            if !workingSignals.isEmpty, let signal = workingSignals.first {
                elements.append(.type(.working))
                elements.append(.optionCrypto(signal))
            }
            
            let longTermSignals = signals.filter { $0.type == .longTerm }
            if !longTermSignals.isEmpty, let signal = longTermSignals.first {
                elements.append(.type(.longTerm))
                elements.append(.optionCrypto(signal))
            }
            
            let closedSignals = signals.filter { $0.type == .closed }
            if !closedSignals.isEmpty, let signal = closedSignals.first {
                elements.append(.type(.closed))
                elements.append(.optionCrypto(signal))
            }
            
            return SignalsTableGroup(filter: .option,
                                     elements: elements)
        }
    }
    
    func makeCryptoGroup() -> Driver<SignalsTableGroup> {
        cryptoSignals.map { signals -> SignalsTableGroup in
            var elements = [SignalsTableElement]()
            
            let workingSignals = signals.filter { $0.type == .working }
            if !workingSignals.isEmpty, let signal = workingSignals.first {
                elements.append(.type(.working))
                elements.append(.optionCrypto(signal))
            }
            
            let longTermSignals = signals.filter { $0.type == .longTerm }
            if !longTermSignals.isEmpty, let signal = longTermSignals.first {
                elements.append(.type(.longTerm))
                elements.append(.optionCrypto(signal))
            }
            
            let closedSignals = signals.filter { $0.type == .closed }
            if !closedSignals.isEmpty, let signal = closedSignals.first {
                elements.append(.type(.closed))
                elements.append(.optionCrypto(signal))
            }
            
            return SignalsTableGroup(filter: .crypto,
                                     elements: elements)
        }
    }
    
    func makeStockSignals() -> Driver<[StockSignal]> {
        signalManager
            .obtainStockSignals()
            .asDriver(onErrorJustReturn: [])
    }
    
    func makeOptionSignals() -> Driver<[OptionCryptoSignal]> {
        signalManager
            .obtainOptionSignals()
            .asDriver(onErrorJustReturn: [])
    }
    
    func makeCryptoSignals() -> Driver<[OptionCryptoSignal]> {
        signalManager
            .obtainCryptoSignals()
            .asDriver(onErrorJustReturn: [])
    }
}
