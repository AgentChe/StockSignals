//
//  NotificationManager.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.10.2021.
//

import RxSwift

protocol NotificationManager {
    func obtaintNotifications() -> Single<[Notification]>
}
