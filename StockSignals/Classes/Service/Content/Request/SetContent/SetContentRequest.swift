//
//  SetContentRequest.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.10.2021.
//

import Alamofire

struct SetContentRequest: APIRequestBody {
    let userToken: String
    let level: Int?
    let assetsSignals: [String]?
    let tradingStyle: String?
    let interested: String?
    let risk: String?
    let industries: [String]?
    let stocks: [String]?
    
    init(userToken: String,
         level: Int? = nil,
         assetsSignals: [String]? = nil,
         tradingStyle: String? = nil,
         interested: String? = nil,
         risk: String? = nil,
         industries: [String]? = nil,
         stocks: [String]? = nil) {
        self.userToken = userToken
        self.level = level
        self.assetsSignals = assetsSignals
        self.tradingStyle = tradingStyle
        self.interested = interested
        self.risk = risk
        self.industries = industries
        self.stocks = stocks
    }
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/v1/onboarding"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        var params: [String: Any] = [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken
        ]
        
        if let level = level {
            params["skill_level"] = level
        }
        
        if let assetsSignals = assetsSignals {
            params["signal_priority"] = assetsSignals
        }
        
        if let tradingStyle = tradingStyle {
            params["trading_style"] = tradingStyle
        }
        
        if let interested = interested {
            params["interesting"] = interested
        }
        
        if let risk = risk {
            params["risk_level"] = risk
        }
        
        if let industries = industries {
            params["industry"] = industries
        }
        
        if let stocks = stocks {
            params["tracking"] = stocks
        }
        
        return params
    }
}
