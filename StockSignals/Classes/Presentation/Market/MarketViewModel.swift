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
}

// MARK: Private
private extension MarketViewModel {
    
}
