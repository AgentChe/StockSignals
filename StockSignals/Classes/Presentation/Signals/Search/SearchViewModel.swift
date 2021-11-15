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
            
            if !searchResult.stockSignals.isEmpty {
                result.append(.type(.stockSignals))
                result.append(.stockSignals(searchResult.stockSignals))
            }
            
            if !searchResult.optionSignals.isEmpty {
                result.append(.type(.optionSignals))
                result.append(.optionCryptoSignals(searchResult.optionSignals))
            }
            
            if !searchResult.cryptoSignals.isEmpty {
                result.append(.type(.cryptoSignals))
                result.append(.optionCryptoSignals(searchResult.cryptoSignals))
            }
            
            if !searchResult.stockQuotations.isEmpty {
                result.append(.type(.stockQuotations))
                result.append(.quotations(searchResult.stockQuotations))
            }
            
            if !searchResult.optionQuotations.isEmpty {
                result.append(.type(.optionQuotations))
                result.append(.quotations(searchResult.optionQuotations))
            }
            
            if !searchResult.cryptoQuotations.isEmpty {
                result.append(.type(.cryptoQuotations))
                result.append(.quotations(searchResult.cryptoQuotations))
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
