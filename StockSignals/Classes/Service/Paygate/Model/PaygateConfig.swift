//
//  PaygateConfig.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.12.2021.
//

struct PaygateConfig {
    let afterOnboarding: Bool
    let technicalAnalysis: Bool
    let watchListLimit: Int
    let screenerSaveLimit: Int
    let screenerLimit: Int
    let signalsLimit: Int
}

// MARK: Codable
extension PaygateConfig: Codable {}

// MARK: Hashable
extension PaygateConfig: Hashable {}
