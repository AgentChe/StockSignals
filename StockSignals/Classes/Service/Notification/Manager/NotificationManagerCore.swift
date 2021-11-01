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
    // TODO
    func obtaintNotifications() -> Single<[Notification]> {
        .deferred { .just(NotificationManagerCore.mocks()) }
//        guard let userToken = SessionManagerCore().getSession()?.userToken else {
//            return .error(SignError.tokenNotFound)
//        }
//
//        let request = GetNotificationsRequest(userToken: userToken)
//
//        return SDKStorage.shared
//            .restApiTransport
//            .callServerApi(requestBody: request)
//            .map { GetNotificationsResponse.map(from: $0) }
    }
    
    // TODO
    static func mocks() -> [Notification] {
        [
            Notification(type: .stock,
                         created: 1634813508,
                         title: "New Signal $AFRM is developing, first target $6.00",
                         description: "$AFRM is developing a base pattern on daily chart,first target $6.00",
                         imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                         isClosed: false),
            
            Notification(type: .crypto,
                         created: 1635517356,
                         title: "Signal Update",
                         description: "$AFRM signal forms cup and handle pattern, keep premium target unchanged",
                         imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                         isClosed: false),
            
            Notification(type: .crypto,
                         created: 1634818918,
                         title: "Closed Signal",
                         description: "$AFRM signal forms cup and handle pattern, keep premium target unchanged",
                         imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                         isClosed: true),
            
            Notification(type: .option,
                         created: 1635768069,
                         title: "Closed Signal",
                         description: "$AFRM signal forms cup and handle pattern, keep premium target unchanged",
                         imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                         isClosed: false),
            
            Notification(type: .option,
                         created: 1635681669,
                         title: "Closed Signal",
                         description: "$AFRM signal forms cup and handle pattern, keep premium target unchanged",
                         imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                         isClosed: false),
            
            Notification(type: .option,
                         created: 1635611669,
                         title: "Closed Signal",
                         description: "$AFRM signal forms cup and handle pattern, keep premium target unchanged",
                         imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                         isClosed: false)
        ]
    }
}
