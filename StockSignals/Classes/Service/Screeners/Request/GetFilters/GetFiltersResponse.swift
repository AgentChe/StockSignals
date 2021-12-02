//
//  GetFiltersResponse.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.12.2021.
//

final class GetFiltersResponse {
    static func map(from response: Any) -> Filters? {
        guard
            let json = response as? [String: Any],
            let body = json["body"] as? [[String: Any]]
        else {
            return nil
        }
        
        var groupFilters = [(group: String, filter: Filter)]()
        var signalFilter: Filter?
        
        body.forEach { element in
            if (element["parent"] as? String) != nil {
                if let bundle = mapGroupFilter(element: element) {
                    groupFilters.append(bundle)
                }
            } else {
                signalFilter = mapFilter(element: element)
            }
        }
        
        let groups = Dictionary(grouping: groupFilters, by: { $0.group })
            .map { key, value -> FilterGroup in
                return FilterGroup(name: key, filters: value.map { $0.filter })
            }
        
        return Filters(signalFilter: signalFilter,
                       groups: groups)
    }
}

// MARK: Private
private extension GetFiltersResponse {
    static func mapGroupFilter(element: [String: Any]) -> (group: String, filter: Filter)? {
        guard
            let filter = mapFilter(element: element),
            let group = element["parent"] as? String
        else {
            return nil
        }
        
        return (group: group, filter: filter)
    }
    
    static func mapFilter(element: [String: Any]) -> Filter? {
        guard
            let title = element["title"] as? String,
            let itemsArray = element["items"] as? [[String: Any]]
        else {
            return nil
        }
        
        let items = itemsArray.compactMap { item -> Filter.Item? in
            guard
                let key = item["key"] as? String,
                let value = item["value"] as? String
            else {
                return nil
            }
            
            return Filter.Item(key: key,
                               value: value)
        }
        
        return Filter(title: title, items: items)
    }
}

//    {
//        "title": "Price",
//        "parent": "Descriptive",
//        "items": [
//            {
//                "key": "sh_price_u1",
//                "value": "Under $1"
//            },
//            ...
//        ]
//    }
//    ...
//]
