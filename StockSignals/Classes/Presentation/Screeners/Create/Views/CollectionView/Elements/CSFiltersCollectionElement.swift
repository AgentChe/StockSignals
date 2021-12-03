//
//  CSFiltersCollectionElement.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.12.2021.
//

enum CSFiltersCollectionElement {
    case signal(CSFiltersCollectionSignalElement)
    case filter(CSFiltersCollectionFilterElement)
    case signalMore
    case filterMore
}

class CSFiltersCollectionSignalElement {
    let item: Filter.Item
    var isSelected: Bool
    
    init(item: Filter.Item, isSelected: Bool = false) {
        self.item = item
        self.isSelected = isSelected
    }
}

class CSFiltersCollectionFilterElement {
    let filter: Filter
    var selectedItem: Filter.Item?
    
    init(filter: Filter, selectedItem: Filter.Item? = nil) {
        self.filter = filter
        self.selectedItem = selectedItem
    }
}
