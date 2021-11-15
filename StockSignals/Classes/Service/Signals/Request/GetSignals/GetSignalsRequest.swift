//
//  GetSignalsRequest.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.11.2021.
//

import Alamofire

struct GetSignalsRequest: APIRequestBody {
    private let userToken: String
    private let type: String
    private let activity: Int?
    
    init(userToken: String,
         type: String,
         activity: Int? = nil) {
        self.userToken = userToken
        self.type = type
        self.activity = activity
    }
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/v1/signal"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        var params: [String: Any] = [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken,
            "type": type
        ]
        
        if let activity = activity {
            params["activity"] = activity
        }
        
        return params
    }
}
