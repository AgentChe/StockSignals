//
//  GetNotificationsRequest.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.10.2021.
//

import Alamofire

struct GetNotificationsRequest: APIRequestBody {
    let userToken: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/v1/notification"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken
        ]
    }
}
