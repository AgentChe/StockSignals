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
    func obtainStockSignals() -> Single<[StockSignal]> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetSignalsRequest(userToken: userToken, type: "stocks")
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetSignalsResponse.stockSignals(response: $0) }
    }
    
    func obtainOptionSignals() -> Single<[OptionCryptoSignal]> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetSignalsRequest(userToken: userToken, type: "option")
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetSignalsResponse.optionCryptoSignals(response: $0) }
    }
    
    func obtainCryptoSignals() -> Single<[OptionCryptoSignal]> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetSignalsRequest(userToken: userToken, type: "crypto")
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetSignalsResponse.optionCryptoSignals(response: $0) }
    }
}
