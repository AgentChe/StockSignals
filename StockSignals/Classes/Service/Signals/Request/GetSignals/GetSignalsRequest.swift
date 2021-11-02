//
//  GetSignalsRequest.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.11.2021.
//

import Alamofire

struct GetSignalsRequest: APIRequestBody {
    let userToken: String
    let type: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/v1/signal"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken,
            "type": type
        ]
    }
}
