//
//  AllUserScreenersViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 07.12.2021.
//

import RxSwift
import RxCocoa

final class AllUserScreenersViewModel {
    lazy var sections = makeSections()
    
    private lazy var filters = makeFilters()
    
    private lazy var screenersManager = ScreenersManagerCore()
}

// MARK: Private
private extension AllUserScreenersViewModel {
    func makeSections() -> Driver<[UserScreener]> {
        filters.flatMapLatest { [weak self] filters -> Driver<ScreenersBundle?> in
            guard let self = self else {
                return .never()
            }
            
            return self.screenersManager
                .obtainBundle(filters: filters)
                .asDriver(onErrorJustReturn: nil)
        }
        .map { bundle -> [UserScreener] in
            bundle?.userScreeners ?? []
        }
    }
    
    func makeFilters() -> Driver<[FilterScreener]?> {
        ScreenersMediator.shared
            .changedFiltersScreeners
            .startWith(())
            .flatMapLatest { [weak self] _ -> Driver<[FilterScreener]?> in
                guard let self = self else {
                    return .never()
                }
                
                return self.screenersManager
                    .obtainFilterScreeners()
                    .map { $0.isEmpty ? nil : $0 }
                    .asDriver(onErrorJustReturn: [])
            }
    }
}
