//
//  ScreenersManagerCore.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.11.2021.
//

import RxSwift

final class ScreenersManagerCore: ScreenersManager {}

// MARK: ScreenersManager
extension ScreenersManagerCore {
    func obtainBundle() -> Single<ScreenersBundle?> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }

        let request = GetScreenersBundleRequest(userToken: userToken)

        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetScreenersBundleResponse.map(from: $0) }
    }
    
    func obtainFilters() -> Single<Filters?> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetFiltersRequest(userToken: userToken)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetFiltersResponse.map(from: $0) }
    }
}
