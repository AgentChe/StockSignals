//
//  GetPaygateConfigResponse.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.12.2021.
//

final class GetPaygateConfigResponse {
    static func map(from response: Any) -> PaygateConfig? {
        guard
            let json = response as? [String: Any],
            let body = json["body"] as? [String: Any]
        else {
            return nil
        }
        
        let afterOnboarding = body["after_onboarding"] as? Bool ?? false
        let technicalAnalysis = body["technical_analysis"] as? Bool ?? false
        let watchListLimit = body["watch_list_limit"] as? Int ?? 100
        let screenerSaveLimit = body["screener_save_limit"] as? Int ?? 100
        let screenerLimit = body["screener_limit"] as? Int ?? 100
        let signalsLimit = body["signals_limit"] as? Int ?? 100
        
        return PaygateConfig(afterOnboarding: afterOnboarding,
                             technicalAnalysis: technicalAnalysis,
                             watchListLimit: watchListLimit,
                             screenerSaveLimit: screenerSaveLimit,
                             screenerLimit: screenerLimit,
                             signalsLimit: signalsLimit)
    }
}
