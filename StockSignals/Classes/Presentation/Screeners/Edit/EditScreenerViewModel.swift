//
//  EditScreenerViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 08.12.2021.
//

import RxSwift
import RxCocoa

final class EditScreenerViewModel {
    lazy var sections = makeSections()
    
    private let filterScreener: FilterScreener
    
    init(filterScreener: FilterScreener) {
        self.filterScreener = filterScreener
    }
    
    private lazy var screenersManager = ScreenersManagerCore()
}

// MARK: Private
private extension EditScreenerViewModel {
    func makeSections() -> Driver<[CSFiltersCollectionSection]> {
        screenersManager
            .obtainFilters()
            .asDriver(onErrorJustReturn: nil)
            .map { [weak self] filters -> [CSFiltersCollectionSection] in
                guard let filterScreener = self?.filterScreener, let filters = filters else {
                    return []
                }
                
                var result = [CSFiltersCollectionSection]()
                
                if let signalFilter = filters.signalFilter {
                    let elements = signalFilter.items.map { item -> CSFiltersCollectionElement in
                        let element = CSFiltersCollectionSignalElement(item: item,
                                                                       isSelected: filterScreener.items.contains(item))
                        return .signal(element)
                    }
                    
                    let section = CSFiltersCollectionSection(name: signalFilter.title,
                                                             elements: elements)
                    result.append(section)
                }
                
                filters.groups.forEach { group in
                    let elements = group.filters.map { filter -> CSFiltersCollectionElement in
                        let selectedItem = filterScreener.items.first(where: { filter.items.contains($0) })
                        let element = CSFiltersCollectionFilterElement(filter: filter, selectedItem: selectedItem)
                        
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
