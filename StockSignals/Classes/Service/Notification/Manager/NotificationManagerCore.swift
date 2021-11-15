//
//  NotificationManagerCore.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.10.2021.
//

import RxSwift

final class NotificationManagerCore: NotificationManager {}

// MARK: Public
extension NotificationManagerCore {
    func obtaintNotifications() -> Single<[Notification]> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }

        let request = GetNotificationsRequest(userToken: userToken)

        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetNotificationsResponse.map(from: $0) }
    }
}
