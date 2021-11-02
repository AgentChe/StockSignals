//
//  ProfileManagerCore.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.11.2021.
//

import RxSwift

final class ProfileManagerCore: ProfileManager {}

// MARK: Public
extension ProfileManagerCore {
    func set(pushToken: String) -> Single<Void> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = SetPushTokenRequest(userToken: userToken, pushToken: pushToken)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { _ in Void() }
    }
}
