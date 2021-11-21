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
    func obtainStockSignals(activity: Int? = nil) -> Single<[StockSignal]> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }

        let request = GetSignalsRequest(userToken: userToken,
                                        type: "stocks",
                                        activity: activity)

        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetSignalsResponse.stockSignals(response: $0) }
    }
    
    func obtainOptionSignals(activity: Int? = nil) -> Single<[OptionCryptoSignal]> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }

        let request = GetSignalsRequest(userToken: userToken,
                                        type: "options",
                                        activity: activity)

        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetSignalsResponse.optionCryptoSignals(response: $0) }
    }
    
    func obtainCryptoSignals(activity: Int? = nil) -> Single<[OptionCryptoSignal]> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }

        let request = GetSignalsRequest(userToken: userToken,
                                        type: "crypto",
                                        activity: activity)

        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetSignalsResponse.optionCryptoSignals(response: $0) }
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
    
    func obtainDetails(by symbol: String) -> Single<Details?> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetDetailsRequest(userToken: userToken, symbol: symbol)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetDetailsResponse.map(from: $0) }
    }
    
    func obtainMarketState() -> Single<Bool> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetMarketStateRequest(userToken: userToken)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetMarketStateResponse.map(from: $0) }
    }
    
    func obtainChart(by symbol: String, range: String) -> Single<Chart?> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetChartRequest(userToken: userToken,
                                      symbol: symbol,
                                      range: range)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetChartResponse.map(from: $0) }
    }
}
