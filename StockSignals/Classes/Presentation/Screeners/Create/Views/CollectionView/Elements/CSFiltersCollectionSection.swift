//
//  CSFiltersCollectionSection.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.12.2021.
//

final class CSFiltersCollectionSection {
    let name: String
    let elements: [CSFiltersCollectionElement]
    var isExpanded: Bool
    
    init(name: String,
         elements: [CSFiltersCollectionElement],
         isExpanded: Bool = false) {
        self.name = name
        self.elements = elements
        self.isExpanded = isExpanded
    }
}
