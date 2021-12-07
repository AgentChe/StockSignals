//
//  ScreenersMediator.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 07.12.2021.
//

import RxSwift
import RxCocoa

final class ScreenersMediator {
    static let shared = ScreenersMediator()
    
    private lazy var changedFiltersScreenersTrigger = PublishRelay<Void>()
    
    private init() {}
}

// MARK: Public
extension ScreenersMediator {
    func notifyAboutChangedFiltersScreeners() {
        DispatchQueue.main.async { [weak self] in
            self?.changedFiltersScreenersTrigger.accept(Void())
        }
    }
}

// MARK: Rx
extension ScreenersMediator {
    var changedFiltersScreeners: Signal<Void> {
        changedFiltersScreenersTrigger.asSignal()
    }
}
