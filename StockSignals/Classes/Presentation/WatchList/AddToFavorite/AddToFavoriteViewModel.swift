//
//  AddToFavoriteViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 19.11.2021.
//

import RxSwift
import RxCocoa

final class AddToFavoriteViewModel {
    lazy var inGroup = PublishRelay<WatchListGroup>()
    lazy var fromGroup = PublishRelay<WatchListGroup>()
    
    lazy var elements = makeElements()
    lazy var command = makeCommand()
    
    private let symbol: BehaviorRelay<String>
    
    private lazy var watchListManager = WatchListManagerCore()
    
    init(symbol: String) {
        self.symbol = BehaviorRelay(value: symbol)
    }
}

// MARK: Private
private extension AddToFavoriteViewModel {
    func makeElements() -> Driver<[AddToFavoriteTableElement]> {
        symbol.flatMapLatest { [weak self] symbol -> Single<[AddToFavoriteTableElement]> in
            guard let self = self else {
                return .never()
            }
            
            return self.watchListManager
                .obtainGroups()
                .map { groups -> [AddToFavoriteTableElement] in
                    groups.map { group -> AddToFavoriteTableElement in
                        AddToFavoriteTableElement(group: group, isFavorite: group.symbols.contains(symbol))
                    }
                }
        }
        .asDriver(onErrorJustReturn: [])
    }
    
    func makeCommand() -> Signal<AddToFavoriteTableElement> {
        let commands = Signal
            .merge(
                inGroup.map { ($0, true) }.asSignal(onErrorSignalWith: .never()),
                fromGroup.map { ($0, false) }.asSignal(onErrorSignalWith: .never())
            )
        
        let symbol = symbol.asSignal(onErrorSignalWith: .never())
        
        return commands
            .withLatestFrom(symbol) { ($0, $1) }
            .flatMap { [weak self] stub, symbol -> Signal<AddToFavoriteTableElement> in
                guard let self = self else {
                    return .never()
                }
                
                let (group, add) = stub
                
                let result: Single<WatchListGroup>
                
                switch add {
                case true:
                    result = self.watchListManager
                        .add(symbol: symbol, in: group)
                case false:
                    result = self.watchListManager
                        .remove(symbol: symbol, from: group)
                }
                
                return result
                    .map { group -> AddToFavoriteTableElement in
                        AddToFavoriteTableElement(group: group, isFavorite: group.symbols.contains(symbol))
                    }
                    .asSignal(onErrorSignalWith: .never())
            }
    }
}
