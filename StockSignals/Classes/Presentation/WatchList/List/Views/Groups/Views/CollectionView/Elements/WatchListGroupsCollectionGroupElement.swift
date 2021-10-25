//
//  WatchListGroupsCollectionGroupElement.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 25.10.2021.
//

final class WatchListGroupsCollectionGroupElement {
    let group: WatchListGroup
    var isEditable: Bool
    
    init(group: WatchListGroup, isEditable: Bool) {
        self.group = group
        self.isEditable = isEditable
    }
}
