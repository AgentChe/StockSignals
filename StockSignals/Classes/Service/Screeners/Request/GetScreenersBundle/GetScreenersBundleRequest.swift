//
//  GetScreenersBundleRequest.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 26.11.2021.
//

import Alamofire

struct GetScreenersBundleRequest: APIRequestBody {
    let userToken: String
    let filters: [FilterScreener]?
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/v1/market"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        var result: [String: Any] = [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken
        ]
        
        if let filters = filters {
            let param = filters.map { filter -> [String: Any] in
                let keys = filter.items.map { item -> [String: Any] in
                    ["key": item.key]
                }
                return [
                    "id": filter.id,
                    "filters": keys
                ]
            }
            result["screeners"] = param
        }
        
        return result
    }
}
