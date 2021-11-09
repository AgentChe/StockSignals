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
    
    lazy var elements = makeElements()
    
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
}
