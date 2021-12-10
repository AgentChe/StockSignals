//
//  GetPaygateResponse.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.12.2021.
//

final class GetPaygateTransferResponse {
    static func transfer(from response: Any) -> Paygate? {
        guard
            let json = response as? [String: Any],
            let body = json["body"] as? [String: Any],
            let headline = body["headline"] as? [String: Any],
            let headlineTop = headline["top"] as? String,
            let headlineBottom = headline["bottom"] as? String,
            let optionsArray = body["options"] as? [[String: Any]]
        else {
            return nil
        }
        
        let options = optionsArray.compactMap { element -> PaygateOption? in
            guard
                let productId = element["product_id"] as? String,
                let title = element["title"] as? String,
                let caption = element["caption"] as? String,
                let subCaption = element["sub_caption"] as? String,
                let button = element["button"] as? [String: Any],
                let buttonCaption = button["caption"] as? String
            else {
                return nil
            }
            
            let buttonSubCaption = button["sub_caption"] as? String
            
            return PaygateOption(productId: productId,
                                 title: title,
                                 caption: caption,
                                 subCaption: subCaption,
                                 buttonCaption: buttonCaption,
                                 buttonSubCaption: buttonSubCaption)
        }
        
        return Paygate(headlineTop: headlineTop,
                       headlineBottom: headlineBottom,
                       options: options)
    }
}
