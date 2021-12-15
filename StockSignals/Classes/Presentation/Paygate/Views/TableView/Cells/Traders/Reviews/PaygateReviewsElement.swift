//
//  PaygateReviewsElement.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 14.12.2021.
//

struct PaygateReviewsElement {
    let image: String
    let text: String
    let name: String
    let stars: Int
}

// MARK: Make
extension PaygateReviewsElement {
    static func makeCollection() -> [PaygateReviewsElement] {
        [
            PaygateReviewsElement(image: "Paygate.Review.1",
                                  text: "Paygate.Review.1.Text".localized,
                                  name: "Paygate.Review.1.Name".localized,
                                  stars: 5),
            
            PaygateReviewsElement(image: "Paygate.Review.2",
                                  text: "Paygate.Review.2.Text".localized,
                                  name: "Paygate.Review.2.Name".localized,
                                  stars: 5),
            
            PaygateReviewsElement(image: "Paygate.Review.3",
                                  text: "Paygate.Review.3.Text".localized,
                                  name: "Paygate.Review.3.Name".localized,
                                  stars: 5),
            
            PaygateReviewsElement(image: "Paygate.Review.4",
                                  text: "Paygate.Review.4.Text".localized,
                                  name: "Paygate.Review.4.Name".localized,
                                  stars: 5)
        ]
    }
}
