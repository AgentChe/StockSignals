//
//  GetPaygateRequest.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.12.2021.
//

import Alamofire

struct GetPaygateRequest: APIRequestBody {
    let userToken: String
    let usedProducts: [String]?
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/v1/paygate"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        var params: [String: Any] = [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken
        ]
        
        if let usedProducts = usedProducts {
            params["usedProducts"] = usedProducts
        }
        
        return params
    }
}
