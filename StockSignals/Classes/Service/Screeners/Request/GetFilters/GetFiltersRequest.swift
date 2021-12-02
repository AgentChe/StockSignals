//
//  GetFiltersRequest.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.12.2021.
//

import Alamofire

struct GetFiltersRequest: APIRequestBody {
    let userToken: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/v1/filters"
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
