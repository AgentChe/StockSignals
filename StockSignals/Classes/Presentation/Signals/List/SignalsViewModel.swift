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
            if !workingSignals.isEmpty {
                elements.append(.type(.working))
                elements.append(.stocksCollection(workingSignals))
            }
            
            let longTermSignals = signals.filter { $0.type == .longTerm }
            if !longTermSignals.isEmpty {
                elements.append(.type(.longTerm))
                elements.append(.stocksCollection(longTermSignals))
            }
            
            let closedSignals = signals.filter { $0.type == .closed }
            if !closedSignals.isEmpty {
                elements.append(.type(.closed))
                elements.append(.stocksCollection(closedSignals))
            }
            
            return SignalsTableGroup(filter: .stock,
                                     elements: elements)
        }
    }
    
    func makeOptionGroup() -> Driver<SignalsTableGroup> {
        optionSignals.map { signals -> SignalsTableGroup in
            var elements = [SignalsTableElement]()
            
            let workingSignals = signals.filter { $0.type == .working }
            if !workingSignals.isEmpty {
                elements.append(.type(.working))
                elements.append(.optionsCryptoCollection(workingSignals))
            }
            
            let longTermSignals = signals.filter { $0.type == .longTerm }
            if !longTermSignals.isEmpty {
                elements.append(.type(.longTerm))
                elements.append(.optionsCryptoCollection(longTermSignals))
            }
            
            let closedSignals = signals.filter { $0.type == .closed }
            if !closedSignals.isEmpty {
                elements.append(.type(.closed))
                elements.append(.optionsCryptoCollection(closedSignals))
            }
            
            return SignalsTableGroup(filter: .option,
                                     elements: elements)
        }
    }
    
    func makeCryptoGroup() -> Driver<SignalsTableGroup> {
        cryptoSignals.map { signals -> SignalsTableGroup in
            var elements = [SignalsTableElement]()
            
            let workingSignals = signals.filter { $0.type == .working }
            if !workingSignals.isEmpty {
                elements.append(.type(.working))
                elements.append(.optionsCryptoCollection(workingSignals))
            }
            
            let longTermSignals = signals.filter { $0.type == .longTerm }
            if !longTermSignals.isEmpty {
                elements.append(.type(.longTerm))
                elements.append(.optionsCryptoCollection(longTermSignals))
            }
            
            let closedSignals = signals.filter { $0.type == .closed }
            if !closedSignals.isEmpty {
                elements.append(.type(.closed))
                elements.append(.optionsCryptoCollection(closedSignals))
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
