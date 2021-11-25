//
//  DictionaryExtension.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 24.11.2021.
//

import Foundation.NSJSONSerialization

extension Dictionary {
    func jsonString() -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
