//
//  SearchResponse.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.11.2021.
//

final class SearchResponse {
    static func map(from response: Any) -> SearchResult? {
        guard
            let json = response as? [String: Any],
            let body = json["body"] as? [String: Any]
        else {
            return nil
        }
        
        let signalsJSON = body["signals"] as? [String: Any] ?? [:]
        
        let stocksSignals = map(stocksSignalsArray: signalsJSON["stocks"] as? [[String: Any]] ?? [])
        let optionSignals = map(optionCryptoArray: signalsJSON["options"] as? [[String: Any]] ?? [])
        let cryptoSignals = map(optionCryptoArray: signalsJSON["crypto"] as? [[String: Any]] ?? [])
        
        let stocksQuotations = map(quotationsArray: body["stocks"] as? [[String: Any]] ?? [])
        let optionQuotations = map(quotationsArray:  body["options"] as? [[String: Any]] ?? [])
        let cryptoQuotations = map(quotationsArray: body["crypto"] as? [[String: Any]] ?? [])
        
        // TODO
        return SearchResult(stockSignals: SignalManagerCore.stockMocks(),
                            optionSignals: SignalManagerCore.optionMocks(),
                            cryptoSignals: SignalManagerCore.cryptoMocks(),
                            stockQuotations: stocksQuotations,
                            optionQuotations: optionQuotations,
                            cryptoQuotations: cryptoQuotations)
    }
}

// MARK: Private
private extension SearchResponse {
    static func map(stocksSignalsArray: [[String: Any]]) -> [StockSignal] {
        return stocksSignalsArray.compactMap { element -> StockSignal? in
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
    
    static func map(optionCryptoArray: [[String: Any]]) -> [OptionCryptoSignal] {
        return optionCryptoArray.compactMap { element -> OptionCryptoSignal? in
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
    
    static func map(quotationsArray: [[String: Any]]) -> [Quotation] {
        return quotationsArray.compactMap { element -> Quotation? in
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
    }
        
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
