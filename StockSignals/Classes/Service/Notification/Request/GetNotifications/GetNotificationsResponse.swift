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
                let created = element["created"] as? TimeInterval,
                let title = element["title"] as? String,
                let description = element["description"] as? String,
                let isClosed = element["is_closed"] as? Bool,
                let imageUrl = element["url"] as? String
            else {
                return nil
            }
            
            return Notification(type: type,
                                created: created,
                                title: title,
                                description: description,
                                imageUrl: imageUrl,
                                isClosed: isClosed)
        }
    }
}

// MARK: Private
private extension GetNotificationsResponse {
    static func type(at rawValue: String) -> NotificationType? {
        switch rawValue {
        case "stock":
            return .stock
        case "option":
            return .option
        case "crypto":
            return .crypto
        default:
            return nil
        }
    }
}
