//
//  ScreenersManager.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.11.2021.
//

import RxSwift

protocol ScreenersManager {
    func obtainBundle(type: String) -> Single<ScreenersBundle?>
}
