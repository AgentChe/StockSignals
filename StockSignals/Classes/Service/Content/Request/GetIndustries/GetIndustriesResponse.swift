//
//  GetIndustriesResponse.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.10.2021.
//

final class GetIndustriesResponse {
    static func map(from response: Any) -> [Industry] {
        guard
            let json = response as? [String: Any],
            let body = json["body"] as? [String]
        else {
            return []
        }
        
        return body.map { Industry(name: $0) }
    }
}
