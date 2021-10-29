//
//  GetIndustriesRequest.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.10.2021.
//

import Alamofire

struct GetIndustriesRequest: APIRequestBody {
    var url: String {
        GlobalDefinitions.domainUrl + "/api/v1/industries"
    }
    
    var method: HTTPMethod {
        .get
    }
}
