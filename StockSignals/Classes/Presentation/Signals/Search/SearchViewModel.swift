//
//  SearchViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.11.2021.
//

import RxSwift
import RxCocoa

final class SearchViewModel {
    lazy var search = PublishRelay<String>()
    lazy var select = PublishRelay<SearchTableTypeElement>()
    
    lazy var elements = makeElements()
    lazy var selectedStockSignals = makeSelectedStockSignals()
    lazy var selectedStockQuotations = makeSelectedStockQuotations()
    lazy var selectedOptionSignals = makeSelectedOptionSignals()
    lazy var selectedOptionQuotations = makeSelectedOptionQuotations()
    lazy var selectedCryptoSignals = makeSelectedCryptoSignals()
    lazy var selectedCryptoQuotations = makeSelectedCryptoQuotations()
    
    private lazy var signalsManager = SignalManagerCore()
    
    private lazy var searchResult = makeSearchResult()
}

// MARK: Private
private extension SearchViewModel {
    func makeElements() -> Driver<[SearchTableElement]> {
        searchResult.map { searchResult -> [SearchTableElement] in
            guard let searchResult = searchResult else {
                return []
            }
            
            var result = [SearchTableElement]()
            
            if let signal = searchResult.stockSignals.first {
                result.append(.type(.stockSignals))
                result.append(.stockSignal(signal))
            }
            
            if let signal = searchResult.optionSignals.first {
                result.append(.type(.optionSignals))
                result.append(.optionCryptoSignal(signal))
            }
            
            if let signal = searchResult.cryptoSignals.first {
                result.append(.type(.cryptoSignals))
                result.append(.optionCryptoSignal(signal))
            }
            
            let stockQuotations = searchResult.stockQuotations.prefix(3)
            if !stockQuotations.isEmpty {
                result.append(.type(.stockQuotations))
                result.append(.quotations(Array(stockQuotations)))
            }
            
            let optionQuotations = searchResult.optionQuotations.prefix(3)
            if !optionQuotations.isEmpty {
                result.append(.type(.optionQuotations))
                result.append(.quotations(Array(optionQuotations)))
            }
            
            let cryptoQuotations = searchResult.cryptoQuotations.prefix(3)
            if !cryptoQuotations.isEmpty {
                result.append(.type(.cryptoQuotations))
                result.append(.quotations(Array(cryptoQuotations)))
            }
            
            return result
        }
    }
    
    func makeSearchResult() -> Driver<SearchResult?> {
        search.flatMapLatest { [weak self] name -> Single<SearchResult?> in
            guard let self = self else {
                return .never()
            }
            
            return self.signalsManager
                .search(name: name)
                .catchAndReturn(nil)
        }
        .asDriver(onErrorJustReturn: nil)
    }
    
    func makeSelectedStockSignals() -> Driver<[StockSignal]> {
        select
            .filter { $0 == .stockSignals }
            .withLatestFrom(searchResult)
            .flatMapLatest { searchResult -> Observable<[StockSignal]> in
                let signals = searchResult?.stockSignals ?? []
                
                return .just(signals)
            }
            .asDriver(onErrorDriveWith: .never())
    }
    
    func makeSelectedStockQuotations() -> Driver<[Quotation]> {
        select
            .filter { $0 == .stockQuotations }
            .withLatestFrom(searchResult)
            .flatMapLatest { searchResult -> Observable<[Quotation]> in
                let quotations = searchResult?.stockQuotations ?? []
                
                return .just(quotations)
            }
            .asDriver(onErrorDriveWith: .never())
    }
    
    func makeSelectedOptionSignals() -> Driver<[OptionCryptoSignal]> {
        select
            .filter { $0 == .optionSignals }
            .withLatestFrom(searchResult)
            .flatMapLatest { searchResult -> Observable<[OptionCryptoSignal]> in
                let signals = searchResult?.optionSignals ?? []
                
                return .just(signals)
            }
            .asDriver(onErrorDriveWith: .never())
    }
    
    func makeSelectedOptionQuotations() -> Driver<[Quotation]> {
        select
            .filter { $0 == .optionQuotations }
            .withLatestFrom(searchResult)
            .flatMapLatest { searchResult -> Observable<[Quotation]> in
                let quotations = searchResult?.optionQuotations ?? []
                
                return .just(quotations)
            }
            .asDriver(onErrorDriveWith: .never())
    }
    
    func makeSelectedCryptoSignals() -> Driver<[OptionCryptoSignal]> {
        select
            .filter { $0 == .cryptoSignals }
            .withLatestFrom(searchResult)
            .flatMapLatest { searchResult -> Observable<[OptionCryptoSignal]> in
                let signals = searchResult?.cryptoSignals ?? []
                
                return .just(signals)
            }
            .asDriver(onErrorDriveWith: .never())
    }
    
    func makeSelectedCryptoQuotations() -> Driver<[Quotation]> {
        select
            .filter { $0 == .cryptoQuotations }
            .withLatestFrom(searchResult)
            .flatMapLatest { searchResult -> Observable<[Quotation]> in
                let quotations = searchResult?.cryptoQuotations ?? []
                
                return .just(quotations)
            }
            .asDriver(onErrorDriveWith: .never())
    }
}
