//
//  SearchRequest.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.11.2021.
//

import Alamofire

struct SearchRequest: APIRequestBody {
    let userToken: String
    let name: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/v1/search"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken,
            "name": name
        ]
    }
}
