//
//  PaygateViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.12.2021.
//

import RxSwift
import RxCocoa

final class PaygateViewModel {
    lazy var elements = makeElements()
    lazy var buttonBundle = makeButtonBundle()
    
    private lazy var paygate = makePaygate()
    
    private lazy var paygateManager = PaygateManagerCore()
}

// MARK: Private
private extension PaygateViewModel {
    func makeElements() -> Driver<[PaygateTableElement]> {
        paygate.map { paygate -> [PaygateTableElement] in
            guard let paygate = paygate else {
                return []
            }
            
            var result = [PaygateTableElement]()
            
            let header = PaygateTableHeader(text1: paygate.headlineTop, text2: paygate.headlineBottom)
            result.append(.header(header))
            
            result.append(.offset(24.scale))
            
            let unlimited = PaygateTableFeature(icon: "Paygate.Cell.UnlimitedSignals",
                                                text1: "Paygate.UnlimitedSignals.Title".localized,
                                                text2: "Paygate.UnlimitedSignals.Text".localized)
            result.append(.feature(unlimited))
            
            result.append(.offset(24.scale))
            
            let buy = PaygateTableFeature(icon: "Paygate.Cell.Buy",
                                          text1: "Paygate.Buy&SellGuidance.Title".localized,
                                          text2: "Paygate.Buy&SellGuidance.Text".localized)
            result.append(.feature(buy))
            
            result.append(.offset(24.scale))
            
            let stock = PaygateTableFeature(icon: "Paygate.Cell.Stock",
                                          text1: "Paygate.StockScreener.Title".localized,
                                          text2: "Paygate.StockScreener.Text".localized)
            result.append(.feature(stock))
            
            result.append(.offset(32.scale))
            
            result.append(.moreFeatures)
            
            result.append(.offset(24.scale))
            
            let analysis = PaygateTableFeature(icon: "Paygate.Cell.Analysis",
                                               text1: "Paygate.TechnicalAnalysis.Title".localized,
                                               text2: "Paygate.TechnicalAnalysis.Text".localized)
            result.append(.feature(analysis))
            
            result.append(.offset(24.scale))
            
            let tracker = PaygateTableFeature(icon: "Paygate.Cell.Tracker",
                                              text1: "Paygate.StockTracker.Title".localized,
                                              text2: "Paygate.StockTracker.Text".localized)
            result.append(.feature(tracker))
            
            return result
        }
    }
    
    func makeButtonBundle() -> Driver<(String, String?)> {
        paygate
            .compactMap { $0 }
            .map {
                ($0.headlineBottom, $0.headlineBottom)
            }
    }
    
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
