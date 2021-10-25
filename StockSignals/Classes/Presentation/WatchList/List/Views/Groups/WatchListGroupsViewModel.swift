//
//  WatchListGroupsViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 23.10.2021.
//

import RxSwift
import RxCocoa

final class WatchListGroupsViewModel {
    lazy var remove = PublishRelay<WatchListGroup>()
    
    lazy var elements = makeElements()
    lazy var removed = makeRemoved()
    
    private lazy var watchListManager = WatchListManagerCore()
}

// MARK: Private
private extension WatchListGroupsViewModel {
    func makeElements() -> Driver<[WatchListGroupsCollectionElement]> {
        watchListManager
            .obtainGroups()
            .map { groups -> [WatchListGroupsCollectionElement] in
                let array = groups.map { group -> WatchListGroupsCollectionElement in
                    let element = WatchListGroupsCollectionGroupElement(group: group,
                                                                        isEditable: false)
                    return .group(element)
                }
                
                
                return array + [.create]
            }
            .asDriver(onErrorJustReturn: [])
    }
    
    func makeRemoved() -> Driver<WatchListGroup> {
        remove.flatMapLatest { [weak self] group -> Single<WatchListGroup> in
            guard let self = self else {
                return .never()
            }
            
            return self.watchListManager
                .remove(group: group)
        }
        .asDriver(onErrorDriveWith: .never())
    }
}
