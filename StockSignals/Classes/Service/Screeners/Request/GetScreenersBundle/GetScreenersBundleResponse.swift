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
        
        return ScreenersBundle(movers: movers,
                               screeners: screeners)
    }
}

// MARK: Private
private extension GetScreenersBundleResponse {
    static func map(moversJSON: [[String: Any]]) -> [Mover] {
        moversJSON.compactMap { json -> Mover? in
            guard
                let title = json["title"] as? String,
                let symbol = json["symbol"] as? String,
                let change = json["change"] as? Double
            else {
                return nil
            }
            
            return Mover(title: title,
                         symbol: symbol,
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
            var stockSignals = [StockSignal]()
            var optionCryptoSignals = [OptionCryptoSignal]()
            
            data.forEach { element in
                if let stockSignal = map(stockSignalJSON: element) {
                    stockSignals.append(stockSignal)
                } else if let optionCryptoSignal = map(optionCryptoSignalJSON: element) {
                    optionCryptoSignals.append(optionCryptoSignal)
                }
            }
            
            return Screener(key: key,
                            value: value,
                            optionCryptoSignals: optionCryptoSignals,
                            stockSignals: stockSignals)
        }
    }
    
    static func map(stockSignalJSON: [String: Any]) -> StockSignal? {
        guard
            let imageUrl = stockSignalJSON["image"] as? String,
            let symbol = stockSignalJSON["symbol"] as? String,
            let company = stockSignalJSON["company"] as? String,
            let maxGain = stockSignalJSON["gain"] as? Double,
            let created = stockSignalJSON["create"] as? TimeInterval,
            let typeRawValue = stockSignalJSON["activity"] as? Int,
            let type = type(at: typeRawValue),
            let targetJSON = stockSignalJSON["target"] as? [String: Any],
            let targetBuy = targetJSON["buy"] as? Double,
            let targetSell = targetJSON["sell"] as? Double
        else {
            return nil
        }
        
        let risk = stockSignalJSON["risk"] as? String
        let targetStop = targetJSON["stop"] as? Double
        let note = stockSignalJSON["note"] as? String
        
        return StockSignal(imageUrl: imageUrl,
                           symbol: symbol,
                           company: company,
                           maxGain: maxGain,
                           created: created,
                           type: type,
                           risk: risk,
                           targetBuy: targetBuy,
                           targetSell: targetSell,
                           targetStop: targetStop,
                           note: note)
    }
    
    static func map(optionCryptoSignalJSON: [String: Any]) -> OptionCryptoSignal? {
        guard
            let imageUrl = optionCryptoSignalJSON["image"] as? String,
            let symbol = optionCryptoSignalJSON["symbol"] as? String,
            let description = optionCryptoSignalJSON["description"] as? String,
            let created = optionCryptoSignalJSON["create"] as? TimeInterval,
            let typeRawValue = optionCryptoSignalJSON["activity"] as? Int,
            let type = type(at: typeRawValue),
            let maxGain = optionCryptoSignalJSON["gain"] as? Double,
            let targetJSON = optionCryptoSignalJSON["target"] as? [String: Any],
            let targetBuy = targetJSON["buy"] as? Double,
            let targetSell = targetJSON["sell"] as? [Double]
        else {
            return nil
        }
        
        let targetStop = targetJSON["stop"] as? Double
        let note = optionCryptoSignalJSON["note"] as? String
        
        return OptionCryptoSignal(imageUrl: imageUrl,
                                  symbol: symbol,
                                  description: description,
                                  created: created,
                                  type: type,
                                  maxGain: maxGain,
                                  targetBuy: targetBuy,
                                  targetStop: targetStop,
                                  targetSell: targetSell,
                                  note: note)
    }
    
    static func type(at rawValue: Int) -> SignalType? {
        switch rawValue {
        case 0:
            return .closed
        case 1:
            return .working
        case 2:
            return .longTerm
        default:
            return nil
        }
    }
}
