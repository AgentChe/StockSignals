//
//  CreateScreenerViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.12.2021.
//

import RxSwift
import RxCocoa

final class CreateScreenerViewModel {
    lazy var sections = makeSections()
    
    private lazy var screenersManager = ScreenersManagerCore()
}

// MARK: Private
private extension CreateScreenerViewModel {
    func makeSections() -> Driver<[CSFiltersCollectionSection]> {
        screenersManager
            .obtainFilters()
            .asDriver(onErrorJustReturn: nil)
            .map { filters -> [CSFiltersCollectionSection] in
                guard let filters = filters else {
                    return []
                }
                
                var result = [CSFiltersCollectionSection]()
                
                if let signalFilter = filters.signalFilter {
                    let elements = signalFilter.items.map { item -> CSFiltersCollectionElement in
                        let element = CSFiltersCollectionSignalElement(item: item)
                        return .signal(element)
                    }
                    
                    let section = CSFiltersCollectionSection(name: signalFilter.title,
                                                             elements: elements)
                    result.append(section)
                }
                
                filters.groups.forEach { group in
                    let elements = group.filters.map { filter -> CSFiltersCollectionElement in
                        let element = CSFiltersCollectionFilterElement(filter: filter)
                        return .filter(element)
                    }
                    
                    let section = CSFiltersCollectionSection(name: group.name,
                                                             elements: elements)
                    result.append(section)
                }
                
                return result
            }
    }
}
