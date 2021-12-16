//
//  DetailsViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.11.2021.
//

import RxSwift
import RxCocoa
import RushSDK

final class DetailsViewModel {
    lazy var filter = PublishRelay<DetailsFilter>()
    
    lazy var company = makeCompany()
    lazy var elements = makeElements()
    
    private lazy var signalsManager = SignalManagerCore()
    private lazy var sessionManager = SessionManagerCore()
    private lazy var paygateManager = PaygateManagerCore()
    
    private lazy var socketManager = DetailsSocketManager(symbol: symbol.value)
    
    private lazy var overviewElements = makeOverviewElements()
    private lazy var summaryElements = makeSummaryElements()
    private lazy var aboutCompanyElements = makeAboutCompanyElements()
    
    private lazy var details = makeDetails()
    private lazy var marketState = makeMarketState()
    private lazy var socketBundle = makeSocketBundle()
    private lazy var activeSubscription = makeActiveSubscription()
    
    private let symbol: BehaviorRelay<String>
    
    private lazy var chartCell = DetailsTableChartCell(symbol: symbol.value)
    
    init(symbol: String) {
        self.symbol = BehaviorRelay(value: symbol)
    }
}

// MARK: Private
private extension DetailsViewModel {
    func makeElements() -> Driver<[DetailsTableElement]> {
        Driver
            .combineLatest(
                filter.asDriver(onErrorDriveWith: .never()),
                overviewElements,
                summaryElements,
                aboutCompanyElements
            ) { filter, overviewElements, summaryElements, aboutCompanyElements -> [DetailsTableElement] in
                switch filter {
                case .overview:
                    return overviewElements
                case .summary:
                    return summaryElements
                case .aboutCompany:
                    return aboutCompanyElements
                }
            }
    }
    
    func makeOverviewElements() -> Driver<[DetailsTableElement]> {
        let preMarket = Driver
            .merge(
                details.map { $0.preMarket },
                socketBundle.map {  $0.preMarket }
            )
        
        let primary = Driver
            .merge(
                details.map { $0.primary },
                socketBundle.map { $0.primary }
            )
        
        
        return Driver.combineLatest(details, marketState, preMarket, primary, activeSubscription) { [weak self] details, marketState, preMarket, primary, activeSubscription -> [DetailsTableElement] in
            guard let self = self else {
                return []
            }
            
            var result = [DetailsTableElement]()
            
            let primary = self.makePrimaryElements(primary: primary)
            let preMarket = self.makePreMarketElements(preMarket: preMarket, marketState: marketState)
            let chart = self.makeChartElements()
            let analytics = self.makeAnalyticsElements(details: details, activeSubscription: activeSubscription)
            let signals = self.makeSignalsElements(details: details)
            
            result.append(contentsOf: primary)
            result.append(contentsOf: preMarket)
            result.append(contentsOf: chart)
            result.append(contentsOf: analytics)
            result.append(contentsOf: signals)
            
            return result
        }
    }
    
    func makePrimaryElements(primary: DetailsPreMarket?) -> [DetailsTableElement] {
        guard let primary = primary else {
            return []
        }
        
        let element = DetailsTableElement.primary(primary)
        let offset = DetailsTableElement.offset(12.scale)
        
        return [element, offset]
    }
    
    func makePreMarketElements(preMarket: DetailsPreMarket?, marketState: Bool) -> [DetailsTableElement] {
        guard let preMarket = preMarket, !marketState else {
            return []
        }
        
        let element = DetailsTableElement.preMarket(preMarket)
        let offset = DetailsTableElement.offset(24.scale)
        
        return [element, offset]
    }
    
    func makeChartElements() -> [DetailsTableElement] {
        let element = DetailsTableElement.chart(chartCell)
        let offset = DetailsTableElement.offset(24.scale)
        
        return [element, offset]
    }
    
    func makeAnalyticsElements(details: Details, activeSubscription: Bool) -> [DetailsTableElement] {
        let config = paygateManager.getConfig() ?? PaygateConfig.default()
        
        let needPayment = activeSubscription ? false : config.technicalAnalysis
        
        if needPayment {
            return [.unlockAnalytics, .offset(24.scale)]
        }
        
        guard let analytics = details.analytics else {
            return []
        }
        
        let title = DetailsTableElement.title("Details.Analytics".localized)
        let offset1 = DetailsTableElement.offset(24.scale)
        let element = DetailsTableElement.analytics(analytics)
        let offset2 = DetailsTableElement.offset(24.scale)

        return [title, offset1, element, offset2]
    }
    
    func makeSignalsElements(details: Details) -> [DetailsTableElement] {
        let stocksElements = details.stockSignals.map { DetailsTableSignal(stockSignal: $0) }
        let optionCryptoElements = details.optionSignals.map { DetailsTableSignal(optionCryptoSignal: $0) }
        
        let signalsElements = stocksElements + optionCryptoElements
        
        let openSignals = signalsElements.filter { $0.type == .working }
        let closedSignals = signalsElements.filter { $0.type == .closed }
        
        var result = [DetailsTableElement]()
        
        if !openSignals.isEmpty {
            result.append(.title("Details.Signals.Open".localized))
            result.append(.offset(12.scale))
            
            let element = DetailsTableElement.signals(openSignals)
            result.append(element)
            
            result.append(.offset(24.scale))
        }
        
        if !closedSignals.isEmpty {
            result.append(.title("Details.Signals.Closed".localized))
            result.append(.offset(12.scale))
            
            let element = DetailsTableElement.signals(closedSignals)
            result.append(element)
            
            result.append(.offset(24.scale))
        }
        
        return result
    }
    
    func makeSummaryElements() -> Driver<[DetailsTableElement]> {
        details.map { details -> [DetailsTableElement] in
            let summary = details.summary
            
            var result = [DetailsTableElement]()
            
            if let sector = summary.sector {
                let element = DetailsTableElement.summary(title: "Details.Summary.Sector".localized,
                                                          value: sector)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let industry = summary.industry {
                let element = DetailsTableElement.summary(title: "Details.Summary.Industry".localized,
                                                          value: industry)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let previousClose = summary.previousClose {
                let element = DetailsTableElement.summary(title: "Details.Summary.PreviousClose".localized,
                                                          value: previousClose)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let open = summary.open {
                let element = DetailsTableElement.summary(title: "Details.Summary.Open".localized,
                                                          value: open)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let marketCap = summary.marketCap {
                let element = DetailsTableElement.summary(title: "Details.Summary.MarketCap".localized,
                                                          value: marketCap)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let beta = summary.beta {
                let element = DetailsTableElement.summary(title: "Details.Summary.Beta".localized,
                                                          value: beta)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let exDividendDate = summary.exDividendDate {
                let element = DetailsTableElement.summary(title: "Details.Summary.Ex-DividendDate".localized,
                                                          value: exDividendDate)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let dividend = summary.dividend {
                let element = DetailsTableElement.summary(title: "Details.Summary.AnnualizedDividend".localized,
                                                          value: dividend)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let yield = summary.yield {
                let element = DetailsTableElement.summary(title: "Details.Summary.Yield".localized,
                                                          value: yield)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let targetEst = summary.targetEst {
                let element = DetailsTableElement.summary(title: "Details.Summary.1yTargetEst".localized,
                                                          value: targetEst)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let peRatio = summary.peRatio {
                let element = DetailsTableElement.summary(title: "Details.Summary.PERatio(TTM)".localized,
                                                          value: peRatio)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let peForward = summary.peForward {
                let element = DetailsTableElement.summary(title: "Details.Summary.ForwardPE1Yr".localized,
                                                          value: peForward)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let volume = summary.volume {
                let element = DetailsTableElement.summary(title: "Details.Summary.Volume".localized,
                                                          value: volume)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let averageVolume = summary.averageVolume {
                let element = DetailsTableElement.summary(title: "Details.Summary.Avg.Volume".localized,
                                                          value: averageVolume)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let dayRangeLow = summary.dayRangeLow, let dayRangeHigh = summary.dayRangeHigh {
                let value = String(format: "Details.Summary.Day's Range.Value".localized, dayRangeLow, dayRangeHigh)
                let element = DetailsTableElement.summary(title: "Details.Summary.Day's Range.Title".localized,
                                                          value: value)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let week52RangeLow = summary.week52RangeLow, let week52RangeHigh = summary.week52RangeHigh {
                let value = String(format: "Details.Summary.52 Week Range.Value".localized, week52RangeLow, week52RangeHigh)
                let element = DetailsTableElement.summary(title: "Details.Summary.52 Week Range.Title".localized,
                                                          value: value)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let eps = summary.eps {
                let element = DetailsTableElement.summary(title: "Details.Summary.Earnings Per Share (EPS)".localized,
                                                          value: eps)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let bid = summary.bid {
                let element = DetailsTableElement.summary(title: "Details.Summary.Bid".localized,
                                                          value: bid)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            if let ask = summary.ask {
                let element = DetailsTableElement.summary(title: "Details.Summary.Ask".localized,
                                                          value: ask)
                result.append(element)
                result.append(.offset(24.scale))
            }
            
            return result
        }
    }
    
    func makeAboutCompanyElements() -> Driver<[DetailsTableElement]> {
        details.map { [DetailsTableElement.aboutCompany($0.about)] }
    }
    
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
    
    func makeMarketState() -> Driver<Bool> {
        signalsManager
            .obtainMarketState()
            .asDriver(onErrorJustReturn: false)
    }
    
    func makeSocketBundle() -> Driver<DetailsSocketManager.Bundle> {
        socketManager
            .bundle
            .asDriver(onErrorDriveWith: .never())
    }
    
    func makeActiveSubscription() -> Driver<Bool> {
        let updated = SDKStorage.shared
            .purchaseMediator
            .rxPurchaseMediatorDidValidateReceipt
            .compactMap { $0?.activeSubscription }
            .asDriver(onErrorJustReturn: false)
        
        let initial = Driver<Bool>
            .deferred { [weak self] in
                guard let this = self else {
                    return .never()
                }
                
                let activeSubscription = this.sessionManager.getSession()?.activeSubscription ?? false
                
                return .just(activeSubscription)
            }
        
        return Driver
            .merge(initial, updated)
    }
}
