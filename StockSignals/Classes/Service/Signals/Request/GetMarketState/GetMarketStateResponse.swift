//
//  GetMarketStateResponse.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 18.11.2021.
//

final class GetMarketStateResponse {
    static func map(from response: Any) -> Bool {
        guard
            let json = response as? [String: Any],
            let body = json["body"] as? [String: Any],
            let market = body["market"] as? Bool
        else {
            return false
        }
        
        return market
    }
}
