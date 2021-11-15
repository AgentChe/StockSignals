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
        let summary = map(summary: summaryJSON)
        
        return Details(imageUrl: imageUrl,
                       symbol: symbol,
                       company: company,
                       about: about,
                       summary: summary)
    }
}

// MARK: Private
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
