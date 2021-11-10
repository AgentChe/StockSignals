//
//  GetWatchListSignalsResponse.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 21.10.2021.
//

final class GetWatchListSignalsResponse {
    static func map(from response: Any) -> [Quotation] {
        guard
            let json = response as? [String: Any],
            let body = json["body"] as? [[String: Any]]
        else {
            return []
        }
        
        return body.compactMap { signalJSON -> Quotation? in
            guard
                let symbol = signalJSON["symbol"] as? String,
                let company = signalJSON["company"] as? String,
                let price = signalJSON["price"] as? Double,
                let change = signalJSON["change"] as? Double,
                let volume = signalJSON["volume"] as? String
            else {
                return nil
            }
            
            let imageUrl = signalJSON["image"] as? String
            let peRatio = signalJSON["pe_ratio"] as? Double
            let marketCap = signalJSON["market_cap"] as? String
            
            return Quotation(imageUrl: imageUrl,
                             symbol: symbol,
                             company: company,
                             price: price,
                             change: change,
                             volume: volume,
                             peRatio: peRatio,
                             marketCap: marketCap)
        }
    }
}
