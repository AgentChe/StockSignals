//
//  NotificationsViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.10.2021.
//

import RxSwift
import RxCocoa

final class NotificationsViewModel {
    lazy var type = PublishRelay<NotificationType>()
    
    lazy var sections = makeSections()
    
    private lazy var selectedGroup = makeSelectedGroup()
    private lazy var groups = makeGroups()
    private lazy var notifications = makeNotifications()
    
    private lazy var notificationManager = NotificationManagerCore()
}

// MARK: Private
private extension NotificationsViewModel {
    func makeSections() -> Driver<[NotificationTableSection]> {
        selectedGroup.map { group -> [NotificationTableSection] in
            let notifications = group.notifications
            
            let calendar = Calendar.current
            
            var todayNotifications = [Notification]()
            var yesterdayNotifications = [Notification]()
            var olderNotifications = [Notification]()
            
            notifications.forEach { notification in
                let date = Date(timeIntervalSince1970: notification.created)
                
                if calendar.isDateInToday(date) {
                    todayNotifications.append(notification)
                } else if calendar.isDateInYesterday(date) {
                    yesterdayNotifications.append(notification)
                } else {
                    olderNotifications.append(notification)
                }
            }
            
            var result = [NotificationTableSection]()
            
            if !todayNotifications.isEmpty {
                result.append(NotificationTableSection(title: "Notifications.Today".localized,
                                                       elements: todayNotifications))
            }
            
            if !yesterdayNotifications.isEmpty {
                result.append(NotificationTableSection(title: "Notifications.Yesterday".localized,
                                                       elements: yesterdayNotifications))
            }
            
            if !olderNotifications.isEmpty {
                result.append(NotificationTableSection(title: "Notifications.Older".localized,
                                                       elements: olderNotifications))
            }
            
            return result
        }
    }
    
    func makeSelectedGroup() -> Driver<NotificationTableGroup> {
        Driver
            .combineLatest(type.asDriver(onErrorDriveWith: .never()), groups) { type, groups -> NotificationTableGroup? in
                groups.first(where: { $0.type == type })
            }
            .compactMap { $0 }
    }
    
    func makeGroups() -> Driver<[NotificationTableGroup]> {
        notifications
            .map { notifications -> [NotificationTableGroup] in
                var stocks = [Notification]()
                var options = [Notification]()
                var cryptos = [Notification]()
                
                notifications.forEach { notification in
                    switch notification.type {
                    case .stock:
                        stocks.append(notification)
                    case .option:
                        options.append(notification)
                    case .crypto:
                        cryptos.append(notification)
                    }
                }
                
                return [
                    NotificationTableGroup(type: .stock, notifications: stocks),
                    NotificationTableGroup(type: .option, notifications: options),
                    NotificationTableGroup(type: .crypto, notifications: cryptos)
                ]
            }
    }
    
    func makeNotifications() -> Driver<[Notification]> {
        notificationManager
            .obtaintNotifications()
            .asDriver(onErrorJustReturn: [])
    }
}
