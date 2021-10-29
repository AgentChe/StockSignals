//
//  ContentManagerCore.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 28.10.2021.
//

import RxSwift

final class ContentManagerCore: ContentManager {}

// MARK: Public
extension ContentManagerCore {
    func obtainIndustries() -> Single<[Industry]> {
        let request = GetIndustriesRequest()
            
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetIndustriesResponse.map(from: $0) }
    }
    
    func set(level: Int? = nil,
             assetsSignals: [String]? = nil,
             tradingStyle: String? = nil,
             interested: String? = nil,
             risk: String? = nil,
             industries: [String]? = nil,
             stocks: [String]? = nil) -> Single<Void> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = SetContentRequest(userToken: userToken,
                                        level: level,
                                        assetsSignals: assetsSignals,
                                        tradingStyle: tradingStyle,
                                        interested: interested,
                                        risk: risk,
                                        industries: industries,
                                        stocks: stocks)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { _ in Void() }
            .catchAndReturn(Void())
    }
}
