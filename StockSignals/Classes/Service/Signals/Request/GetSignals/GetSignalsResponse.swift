//
//  GetSignalsResponse.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.11.2021.
//

final class GetSignalsResponse {
    static func stockSignals(response: Any) -> [StockSignal] {
        guard
            let json = response as? [String: Any],
            let body = json["body"] as? [[String: Any]]
        else {
            return []
        }
        
        return body.compactMap { element -> StockSignal? in
            guard
                let imageUrl = element["image"] as? String,
                let symbol = element["symbol"] as? String,
                let company = element["company"] as? String,
                let maxGain = element["max_gain"] as? Double,
                let created = element["created"] as? TimeInterval,
                let typeRawValue = element["type"] as? Int,
                let type = type(at: typeRawValue),
                let targetJSON = element["target"] as? [String: Any],
                let targetBuy = targetJSON["buy"] as? Double,
                let targetSell = targetJSON["sell"] as? Double,
                let targetStop = targetJSON["stop"] as? Double
            else {
                return nil
            }
            
            let risk = element["risk"] as? String
            let note = element["note"] as? String
            
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
    }
    
    static func optionCryptoSignals(response: Any) -> [OptionCryptoSignal] {
        guard
            let json = response as? [String: Any],
            let body = json["body"] as? [[String: Any]]
        else {
            return []
        }
        
        return body.compactMap { element -> OptionCryptoSignal? in
            guard
                let imageUrl = element["image"] as? String,
                let symbol = element["symbol"] as? String,
                let description = element["description"] as? String,
                let created = element["created"] as? TimeInterval,
                let typeRawValue = element["type"] as? Int,
                let type = type(at: typeRawValue),
                let maxGain = element["max_gain"] as? Double,
                let targetJSON = element["target"] as? [String: Any],
                let targetBuy = targetJSON["buy"] as? Double,
                let targetStop = targetJSON["stop"] as? Double,
                let targetSell = targetJSON["sell"] as? [Double]
            else {
                return nil
            }
            
            let note = element["note"] as? String
            
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
    }
}

// MARK: Private
private extension GetSignalsResponse {
    static func type(at rawValue: Int) -> SignalType? {
        switch rawValue {
        case 0:
            return .working
        case 1:
            return .closed
        case 2:
            return .longTerm
        default:
            return nil
        }
    }
}
