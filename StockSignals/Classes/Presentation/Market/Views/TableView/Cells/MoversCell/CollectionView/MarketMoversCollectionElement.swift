//
//  MarketMoversCollectionElement.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 30.11.2021.
//

import UIKit

struct MarketMoversCollectionElement {
    let mover: Mover
    let color: UIColor?
    
    private static var colors = [
        UIColor(integralRed: 99, green: 255, blue: 218),
        UIColor(integralRed: 114, green: 136, blue: 255),
        UIColor(integralRed: 255, green: 174, blue: 100),
        UIColor(integralRed: 36, green: 221, blue: 119),
        UIColor(integralRed: 229, green: 97, blue: 241),
        UIColor(integralRed: 238, green: 192, blue: 72),
        UIColor(integralRed: 129, green: 232, blue: 129),
        UIColor(integralRed: 112, green: 226, blue: 248),
        UIColor(integralRed: 238, green: 142, blue: 72),
        UIColor(integralRed: 62, green: 89, blue: 223),
        UIColor(integralRed: 252, green: 247, blue: 122),
        UIColor(integralRed: 172, green: 112, blue: 248),
        UIColor(integralRed: 232, green: 129, blue: 232),
        UIColor(integralRed: 255, green: 102, blue: 102),
        UIColor(integralRed: 104, green: 169, blue: 255)
    ]
    
    init(mover: Mover) {
        self.mover = mover
        
        color = MarketMoversCollectionElement.colors.randomElement()
    }
}
