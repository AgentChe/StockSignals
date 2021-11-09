//
//  SignalManagerCore.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.11.2021.
//

import RxSwift

final class SignalManagerCore: SignalManager {}

// MARK: Public
extension SignalManagerCore {
    // TODO
    func obtainStockSignals() -> Single<[StockSignal]> {
        .deferred { .just(Self.stockMocks()) }
//        guard let userToken = SessionManagerCore().getSession()?.userToken else {
//            return .error(SignError.tokenNotFound)
//        }
//
//        let request = GetSignalsRequest(userToken: userToken, type: "stocks")
//
//        return SDKStorage.shared
//            .restApiTransport
//            .callServerApi(requestBody: request)
//            .map { GetSignalsResponse.stockSignals(response: $0) }
    }
    
    // TODO
    func obtainOptionSignals() -> Single<[OptionCryptoSignal]> {
        .deferred { .just(Self.optionMocks()) }
//        guard let userToken = SessionManagerCore().getSession()?.userToken else {
//            return .error(SignError.tokenNotFound)
//        }
//
//        let request = GetSignalsRequest(userToken: userToken, type: "option")
//
//        return SDKStorage.shared
//            .restApiTransport
//            .callServerApi(requestBody: request)
//            .map { GetSignalsResponse.optionCryptoSignals(response: $0) }
    }
    
    // TODO
    func obtainCryptoSignals() -> Single<[OptionCryptoSignal]> {
        .deferred { .just(Self.cryptoMocks()) }
//        guard let userToken = SessionManagerCore().getSession()?.userToken else {
//            return .error(SignError.tokenNotFound)
//        }
//
//        let request = GetSignalsRequest(userToken: userToken, type: "crypto")
//
//        return SDKStorage.shared
//            .restApiTransport
//            .callServerApi(requestBody: request)
//            .map { GetSignalsResponse.optionCryptoSignals(response: $0) }
    }
    
    func search(name: String) -> Single<SearchResult?> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = SearchRequest(userToken: userToken, name: name)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { SearchResponse.map(from: $0) }
    }
}

// TODO
extension SignalManagerCore {
    static func stockMocks() -> [StockSignal] {
        [
            StockSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                        symbol: "Mic",
                        company: "Amazon",
                        maxGain: 3.02,
                        created: 87984769879,
                        type: .working,
                        risk: nil,
                        targetBuy: 127, targetSell: 178, targetStop: 110,
                        note: nil),
            
            StockSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                        symbol: "AMZ",
                        company: "Amazon",
                        maxGain: 3.02,
                        created: 87984769879,
                        type: .working,
                        risk: "low",
                        targetBuy: 127, targetSell: 178, targetStop: 110,
                        note: nil),
            
            StockSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                        symbol: "GHR",
                        company: "Amazon",
                        maxGain: 1,
                        created: 87984769879,
                        type: .working,
                        risk: "low",
                        targetBuy: 127, targetSell: 178, targetStop: 110,
                        note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            StockSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                        symbol: "AMZ",
                        company: "Amazon",
                        maxGain: 3.02,
                        created: 87984769879,
                        type: .closed,
                        risk: "low",
                        targetBuy: 127, targetSell: 178, targetStop: 110,
                        note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            StockSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                        symbol: "AMZ",
                        company: "Amazon",
                        maxGain: 3.02,
                        created: 87984769879,
                        type: .longTerm,
                        risk: "low",
                        targetBuy: 127, targetSell: 178, targetStop: 110,
                        note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            StockSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                        symbol: "AMZ",
                        company: "Amazon",
                        maxGain: 3.02,
                        created: 87984769879,
                        type: .longTerm,
                        risk: "low",
                        targetBuy: 127, targetSell: 178, targetStop: 110,
                        note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            StockSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                        symbol: "AMZ",
                        company: "Amazon",
                        maxGain: 3.02,
                        created: 87984769879,
                        type: .longTerm,
                        risk: "low",
                        targetBuy: 127, targetSell: 178, targetStop: 110,
                        note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
        ]
    }
    
    static func optionMocks() -> [OptionCryptoSignal] {
        [
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .working,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .working,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .working,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .working,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .working,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .working,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .closed,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .working,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .longTerm,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .longTerm,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .closed,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .working,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .working,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .working,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .longTerm,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
        ]
    }
    
    static func cryptoMocks() -> [OptionCryptoSignal] {
        [
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .closed,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .closed,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .closed,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .closed,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .closed,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .closed,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .closed,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .closed,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .closed,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .closed,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .closed,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .closed,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .closed,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .closed,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
            
            OptionCryptoSignal(imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/amazon-512.png",
                               symbol: "AMZ",
                               description: "AAPL 10/15/2021 145P",
                               created: 87984769879,
                               type: .closed,
                               maxGain: 200, targetBuy: 0.71, targetStop: 0.36,
                               targetSell: [1.49, 2.86, 5.03],
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target"),
        ]
    }
}
