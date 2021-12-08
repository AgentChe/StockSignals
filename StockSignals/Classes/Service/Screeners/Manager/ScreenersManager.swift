//
//  ScreenersManager.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.11.2021.
//

import RxSwift

protocol ScreenersManager {
    func obtainBundle(filters: [FilterScreener]?) -> Single<ScreenersBundle?>
    
    func obtainFilters() -> Single<Filters?>
    
    func add(filterScreener: FilterScreener) -> Single<FilterScreener>
    func delete(filterScreenerId: String) -> Single<Void>
    func obtainFilterScreeners() -> Single<[FilterScreener]>
}
