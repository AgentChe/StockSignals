//
//  GetScreenersBundleResponse.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.11.2021.
//

final class GetScreenersBundleResponse {
    static func map(from response: Any) -> ScreenersBundle? {
        guard
            let json = response as? [String: Any],
            let body = json["body"] as? [String: Any]
        else {
            return nil
        }
        
        let moversJSON = body["movers"] as? [[String: Any]] ?? []
        let movers = map(moversJSON: moversJSON)
        
        let screenersJSON = body["screeners"] as? [[String: Any]] ?? []
        let screeners = map(screenersJSON: screenersJSON)
        
        let userScreenersJSON = body["user"] as? [[String: Any]] ?? []
        let userScreeners = map(userScreenersJSON: userScreenersJSON)
        
        return ScreenersBundle(movers: movers,
                               screeners: screeners,
                               userScreeners: userScreeners)
    }
}

// MARK: Private
private extension GetScreenersBundleResponse {
    static func map(moversJSON: [[String: Any]]) -> [Mover] {
        moversJSON.compactMap { json -> Mover? in
            guard
                let title = json["value"] as? String,
                let symbol = json["symbol"] as? String,
                let key = json["key"] as? String,
                let change = json["change"] as? Double
            else {
                return nil
            }
            
            return Mover(title: title,
                         symbol: symbol,
                         key: key,
                         change: change)
        }
    }
    
    static func map(screenersJSON: [[String: Any]]) -> [Screener] {
        screenersJSON.compactMap { json -> Screener? in
            guard
                let key = json["key"] as? String,
                let value = json["value"] as? String
            else {
                return nil
            }
            
            let data = json["data"] as? [[String: Any]] ?? []
            let quotations = data.compactMap { element -> Quotation? in
                guard
                    let symbol = element["symbol"] as? String,
                    let company = element["company"] as? String,
                    let price = element["price"] as? Double,
                    let change = element["change"] as? Double,
                    let volume = element["volume"] as? String
                else {
                    return nil
                }
                
                let imageUrl = element["image"] as? String
                let peRatio = element["pe_ratio"] as? Double
                let marketCap = element["market_cap"] as? String
                
                return Quotation(imageUrl: imageUrl,
                                 symbol: symbol,
                                 company: company,
                                 price: price,
                                 change: change,
                                 volume: volume,
                                 peRatio: peRatio,
                                 marketCap: marketCap)
            }
            
            return Screener(key: key,
                            value: value,
                            quotations: quotations)
        }
    }
    
    static func map(userScreenersJSON: [[String: Any]]) -> [UserScreener] {
        userScreenersJSON.compactMap { json -> UserScreener? in
            guard
                let name = json["title"] as? String,
                let data = json["data"] as? [[String: Any]]
            else {
                return nil
            }
            
            let quotations = data.compactMap { element -> Quotation? in
                guard
                    let symbol = element["symbol"] as? String,
                    let company = element["company"] as? String,
                    let price = element["price"] as? Double,
                    let change = element["change"] as? Double,
                    let volume = element["volume"] as? String
                else {
                    return nil
                }
                
                let imageUrl = element["image"] as? String
                let peRatio = element["pe_ratio"] as? Double
                let marketCap = element["market_cap"] as? String
                
                return Quotation(imageUrl: imageUrl,
                                 symbol: symbol,
                                 company: company,
                                 price: price,
                                 change: change,
                                 volume: volume,
                                 peRatio: peRatio,
                                 marketCap: marketCap)
            }
            
            return UserScreener(name: name,
                                quotations: quotations)
        }
    }
}
