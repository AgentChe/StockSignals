//
//  NotificationType.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.10.2021.
//

enum NotificationType: String {
    case stock, option, crypto
}

// MARK: Codable
extension NotificationType: Codable {}
