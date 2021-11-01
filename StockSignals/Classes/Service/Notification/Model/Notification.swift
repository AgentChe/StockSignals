//
//  Notification.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.10.2021.
//

struct Notification {
    let type: NotificationType
    let created: TimeInterval
    let title: String
    let description: String
    let imageUrl: String
    let isClosed: Bool
}
