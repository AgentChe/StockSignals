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

// MARK: Make
extension PaygateConfig {
    static func `default`() -> PaygateConfig {
        PaygateConfig(afterOnboarding: false,
                      technicalAnalysis: false,
                      watchListLimit: 1000,
                      screenerSaveLimit: 1000,
                      screenerLimit: 1000,
                      signalsLimit: 1000)
    }
}

// MARK: Codable
extension PaygateConfig: Codable {}

// MARK: Hashable
extension PaygateConfig: Hashable {}
