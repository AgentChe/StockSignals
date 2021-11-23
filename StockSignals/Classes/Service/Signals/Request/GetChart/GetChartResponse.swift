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
            let timestamp = body["timestamp"] as? [Double],
            let open = body["open"] as? [Double],
            let close = body["close"] as? [Double],
            let low = body["low"] as? [Double],
            let high = body["high"] as? [Double],
            let volume = body["volume"] as? [Double]
        else {
            return nil
        }
        
        let count = min(timestamp.count, close.count)
        let timestampPrefix = Array(timestamp.prefix(count))
        let closePrefix = Array(close.prefix(count))
        
        return Chart(timestamp: timestampPrefix,
                     open: open,
                     close: closePrefix,
                     low: low,
                     high: high,
                     volume: volume)
    }
}
