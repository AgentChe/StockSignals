//
//  GetNotificationsResponse.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.10.2021.
//

final class GetNotificationsResponse {
    static func map(from response: Any) -> [Notification] {
        guard
            let json = response as? [String: Any],
            let body = json["body"] as? [[String: Any]]
        else {
            return []
        }
            
        return body.compactMap { element -> Notification? in
            guard
                let typeRawValue = element["type"] as? String,
                let type = type(at: typeRawValue),
                let created = element["create"] as? TimeInterval,
                let title = element["title"] as? String,
                let description = element["description"] as? String,
                let isClosed = element["is_closed"] as? Bool,
                let symbol = element["symbol"] as? String
            else {
                return nil
            }
            
            let imageUrl = element["image"] as? String
            
            return Notification(type: type,
                                created: created,
                                title: title,
                                description: description,
                                imageUrl: imageUrl,
                                isClosed: isClosed,
                                symbol: symbol)
        }
    }
}

// MARK: Private
private extension GetNotificationsResponse {
    static func type(at rawValue: String) -> NotificationType? {
        switch rawValue {
        case "stocks":
            return .stock
        case "options":
            return .option
        case "crypto":
            return .crypto
        default:
            return nil
        }
    }
}
