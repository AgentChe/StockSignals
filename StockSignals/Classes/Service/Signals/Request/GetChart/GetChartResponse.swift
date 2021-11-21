//
//  GetChartResponse.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 20.11.2021.
//

final class GetChartResponse {
    static func map(from response: Any) -> Chart? {
        guard
            let json = response as? [String: Any],
            let body = json["body"] as? [String: Any],
            let timestamp = body["timestamp"] as? [Int],
            let open = body["open"] as? [Double],
            let close = body["close"] as? [Double],
            let low = body["low"] as? [Double],
            let high = body["high"] as? [Double],
            let volume = body["volume"] as? [Int]
        else {
            return nil
        }
        
        return Chart(timestamp: timestamp,
                     open: open,
                     close: close,
                     low: low,
                     high: high,
                     volume: volume)
    }
}
