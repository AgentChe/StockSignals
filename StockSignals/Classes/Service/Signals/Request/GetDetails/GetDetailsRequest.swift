//
//  GetDetailsRequest.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.11.2021.
//

import Alamofire

struct GetDetailsRequest: APIRequestBody {
    let userToken: String
    let symbol: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/v1/symbol"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken,
            "symbol": symbol
        ]
    }
}
