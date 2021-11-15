//
//  GetWatchListSignalsRequest.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 21.10.2021.
//

import Alamofire

struct GetWatchListSignalsRequest: APIRequestBody {
    private let userToken: String
    private let symbols: String?
    
    init(userToken: String, symbols: String? = nil) {
        self.userToken = userToken
        self.symbols = symbols
    }
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/v1/watch"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        var params = [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken
        ]
        
        if let symbols = symbols {
            params["symbols"] = symbols
        }
        
        return params
    }
}
