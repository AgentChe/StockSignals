//
//  GetPaygateConfigRequest.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.12.2021.
//

import Alamofire

struct GetPaygateConfigRequest: APIRequestBody {
    var url: String {
        GlobalDefinitions.domainUrl + "/api/v1/payments"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey
        ]
    }
    
    var encoding: ParameterEncoding {
        URLEncoding.queryString
    }
}
