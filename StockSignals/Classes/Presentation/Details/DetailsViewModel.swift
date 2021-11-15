//
//  DetailsViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.11.2021.
//

import RxSwift
import RxCocoa

final class DetailsViewModel {
    lazy var filter = PublishRelay<DetailsFilter>()
    
    lazy var company = makeCompany()
    
    private lazy var signalsManager = SignalManagerCore()
    
    private lazy var details = makeDetails()
    
    private let symbol: BehaviorRelay<String>
    
    init(symbol: String) {
        self.symbol = BehaviorRelay(value: symbol)
    }
}

// MARK: Private
private extension DetailsViewModel {
    func makeCompany() -> Driver<String> {
        details.map { $0.company }
    }
    
    func makeDetails() -> Driver<Details> {
        symbol.flatMapLatest { [weak self] symbol -> Single<Details?> in
            guard let self = self else {
                return .never()
            }
            
            return self.signalsManager
                .obtainDetails(by: symbol)
        }
        .compactMap { $0 }
        .asDriver(onErrorDriveWith: .never())
    }
}
