//
//  ScreenersManager.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.11.2021.
//

import RxSwift

protocol ScreenersManager {
    func obtainBundle() -> Single<ScreenersBundle?>
    
    func obtainFilters() -> Single<Filters?>
}
