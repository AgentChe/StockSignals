//
//  FiltersItemsTableElement.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.12.2021.
//

final class FiltersItemsTableElement {
    let item: Filter.Item
    var isSelected: Bool
    
    init(item: Filter.Item,
         isSelected: Bool = false) {
        self.item = item
        self.isSelected = isSelected
    }
}
