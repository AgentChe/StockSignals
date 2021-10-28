//
//  GetWatchListSignalsRequest.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 21.10.2021.
//

import Alamofire

struct GetWatchListSignalsRequest: APIRequestBody {
    let userToken: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/v1/watch"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "key": GlobalDefinitions.apiKey,
            "user_token": userToken
        ]
    }
}
