//
//  GetMarketStateRequest.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 18.11.2021.
//

import Alamofire

struct GetMarketStateRequest: APIRequestBody {
    let userToken: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/v1/status"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken
        ]
    }
    
    var encoding: ParameterEncoding {
        URLEncoding.queryString
    }
}
