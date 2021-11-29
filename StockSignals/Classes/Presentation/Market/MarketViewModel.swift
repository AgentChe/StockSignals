//
//  MarketViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.11.2021.
//

import RxSwift
import RxCocoa

final class MarketViewModel {
    lazy var filter = PublishRelay<NotificationType>()
    
    lazy var elements = makeElements()
    
    private lazy var screenersManager = ScreenersManagerCore()
}

// MARK: Private
private extension MarketViewModel {
    func makeElements() -> Driver<[MarketTableElement]> {
        filter.flatMapLatest { [weak self] filter -> Single<ScreenersBundle?> in
            guard let self = self else {
                return .never()
            }
            
            let converted = self.convert(filter: filter)
            
            return self.screenersManager
                .obtainBundle(type: converted)
                .catchAndReturn(nil)
        }
        .map { bundle -> [MarketTableElement] in
            return []
        }
        .asDriver(onErrorJustReturn: [])
    }
    
    func convert(filter: NotificationType) -> String {
        switch filter {
        case .stock:
            return "stocks"
        case .option:
            return "options"
        case .crypto:
            return "crypto"
        }
    }
}
