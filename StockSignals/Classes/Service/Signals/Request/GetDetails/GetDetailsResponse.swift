//
//  GetDetailsResponse.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.11.2021.
//

final class GetDetailsResponse {
    static func map(from response: Any) -> Details? {
        guard
            let json = response as? [String: Any],
            let body = json["body"] as? [String: Any],
            let symbol = body["symbol"] as? String,
            let company = body["company"] as? String,
            let about = body["about"] as? String,
            let summaryJSON = body["summary"] as? [String: Any]
        else {
            return nil
        }
        
        let imageUrl = body["image"] as? String
        
        let analyticsJSON = body["analysis"] as? [String: Any] ?? [:]
        let analytics = map(analytics: analyticsJSON)
        
        let signalsJSON = body["signals"] as? [String: Any] ?? [:]
        let signals = map(signals: signalsJSON)
        
        let summary = map(summary: summaryJSON)
        
        return Details(imageUrl: imageUrl,
                       symbol: symbol,
                       company: company,
                       about: about,
                       analytics: analytics,
                       stockSignals: signals.0,
                       optionSignals: signals.1,
                       summary: summary)
    }
}

// MARK: Private(Signals)
private extension GetDetailsResponse {
    static func map(analytics: [String: Any]) -> DetailsAnalytics? {
        guard
            let rating = analytics["average_analyst_rating"] as? Double,
            let values = analytics["average_ratings"] as? [[String: Any]]
        else {
            return nil
        }
        
        let possibleRatings = values.compactMap { json -> DetailsAnalyticsRating? in
            guard
                let value = json["value"] as? Int,
                let title = json["name"] as? String
            else {
                return nil
            }
            
            return DetailsAnalyticsRating(value: value, title: title)
        }
        
        let description = analytics["description"] as? String
        
        return DetailsAnalytics(averageRating: rating,
                                possibleRatings: possibleRatings,
                                description: description)
    }
    
    static func map(signals: [String: Any]) -> ([StockSignal], [OptionCryptoSignal]) {
        let openJSON = signals["open"] as? [[String: Any]] ?? []
        let closeJSON = signals["close"] as? [[String: Any]] ?? []
        
        var stockSignals = [StockSignal]()
        var optionCryptoSignals = [OptionCryptoSignal]()
        
        openJSON.forEach { json in
            if let signal = map(stockSignalJSON: json) {
                stockSignals.append(signal)
            } else if let signal = map(optionCryptoSignalJSON: json) {
                optionCryptoSignals.append(signal)
            }
        }
        
        closeJSON.forEach { json in
            if let signal = map(stockSignalJSON: json) {
                stockSignals.append(signal)
            } else if let signal = map(optionCryptoSignalJSON: json) {
                optionCryptoSignals.append(signal)
            }
        }
        
        return (stockSignals, optionCryptoSignals)
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

// MARK: Private(Summary)
private extension GetDetailsResponse {
    static func map(summary: [String: Any]) -> DetailsSummary {
        let dayRangeJSON = summary["day_range"] as? [String: Any] ?? [:]
        let week52RangeJSON = summary["52_week_range"] as? [String: Any] ?? [:]
        
        return DetailsSummary(sector: summary["sector"] as? String,
                              industry: summary["industry"] as? String,
                              previousClose: summary["previous_close"] as? String,
                              open: summary["open"] as? String,
                              marketCap: summary["market_cap"] as? String,
                              beta: summary["beta"] as? String,
                              exDividendDate: summary["ex_dividend_date"] as? String,
                              dividend: summary["dividend"] as? String,
                              yield: summary["yield"] as? String,
                              targetEst: summary["target_est"] as? String,
                              peRatio: summary["pe_ratio"] as? String,
                              peForward: summary["pe_forward"] as? String,
                              volume: summary["volume"] as? String,
                              averageVolume: summary["average_volume"] as? String,
                              dayRangeHigh: dayRangeJSON["high"] as? String,
                              dayRangeLow: dayRangeJSON["low"] as? String,
                              week52RangeHigh: week52RangeJSON["high"] as? String,
                              week52RangeLow: week52RangeJSON["low"] as? String,
                              eps: summary["eps"] as? String,
                              bid: summary["bid"] as? String,
                              ask: summary["ask"] as? String)
    }
}
