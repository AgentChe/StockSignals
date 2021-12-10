//
//  PaygateViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.12.2021.
//

import RxSwift
import RxCocoa

final class PaygateViewModel {
    lazy var paygate = makePaygate()
    
    private lazy var paygateManager = PaygateManagerCore()
}

// MARK: Private
private extension PaygateViewModel {
    func makePaygate() -> Driver<Paygate?> {
        paygateManager
            .obtainPaygateTransfer()
            .flatMap { [weak self] transfer -> Single<Paygate?> in
                guard let self = self, let transfer = transfer else {
                    return .never()
                }
                
                return self.paygateManager
                    .preparePrices(for: transfer)
            }
            .asDriver(onErrorJustReturn: nil)
    }
}
