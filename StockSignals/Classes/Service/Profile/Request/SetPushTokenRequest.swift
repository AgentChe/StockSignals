//
//  SetPushToken.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.11.2021.
//

import Alamofire

struct SetPushTokenRequest: APIRequestBody {
    let userToken: String
    let pushToken: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/v1/profile"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        let data = [
            "notification_key": pushToken
        ]
        
        return [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken,
            "event": "set",
            "data": data
        ]
    }
}
