//
//  CreateWatchListGroupViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 24.10.2021.
//

import RxSwift
import RxCocoa

final class CreateWatchListGroupViewModel {
    lazy var create = PublishRelay<String>()
    
    lazy var group = makeGroup()
    
    private lazy var watchListManager = WatchListManagerCore()
}

// MARK: Private
private extension CreateWatchListGroupViewModel {
    func makeGroup() -> Driver<WatchListGroup> {
        create.flatMapLatest { [weak self] name -> Single<WatchListGroup> in
            guard let self = self else {
                return .never()
            }
            
            return self.watchListManager.createGroup(name: name, symbols: [])
        }
        .asDriver(onErrorDriveWith: .never())
    }
}
