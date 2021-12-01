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
    private let keys: [String]?
    
    init(userToken: String, symbols: String? = nil, keys: [String]? = nil) {
        self.userToken = userToken
        self.symbols = symbols
        self.keys = keys
    }
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/v1/watch"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        var params: [String: Any] = [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken
        ]
        
        if let symbols = symbols {
            params["symbols"] = symbols
        }
        
        if let keys = keys {
            let array = keys.map {
                ["key": $0]
            }
            params["filters"] = array
        }
        
        return params
    }
}
