//
//  GetChartRequest.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 20.11.2021.
//

import Alamofire

struct GetChartRequest: APIRequestBody {
    let userToken: String
    let symbol: String
    let range: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/v1/chart"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken,
            "symbol": symbol,
            "range": range
        ]
    }
}
