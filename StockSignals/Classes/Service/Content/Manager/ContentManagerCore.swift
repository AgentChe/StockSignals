//
//  ContentManagerCore.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 28.10.2021.
//

import RxSwift

final class ContentManagerCore: ContentManager {}

// MARK: Public
extension ContentManagerCore {
    // TODO
    func obtainIndustries() -> Single<[Industry]> {
        .just([
            Industry(id: 0, name: "Advertising Agencies"),
            Industry(id: 1, name: "Aerospace & Defense"),
            Industry(id: 2, name: "Agricultural Inputs"),
            Industry(id: 3, name: "Airlines"),
            Industry(id: 4, name: "Airports & Air Services"),
            Industry(id: 5, name: "Aluminum"),
            Industry(id: 6, name: "Apparel Manufacturing"),
            Industry(id: 7, name: "Apparel Retail"),
            Industry(id: 8, name: "Asset Management"),
            Industry(id: 9, name: "Auto Manufacturers"),
            Industry(id: 10, name: "Banks - Diversified"),
            Industry(id: 11, name: "Beverages - Brewers"),
            Industry(id: 12, name: "Aluminum"),
            Industry(id: 13, name: "Agencies")
        ])
    }
    
    // TODO
    func obtainStock() -> Single<[ContentStock]> {
        .just([
            ContentStock(id: 0,
                         imageUrl: "https://img.etimg.com/thumb/msid-85584610,width-640,resizemode-4,imgsize-29562/4-bitcoin-gold.jpg",
                         name: "Apple",
                         code: "(AAPL)"),
            
            ContentStock(id: 1,
                         imageUrl: "https://img.etimg.com/thumb/msid-85584610,width-640,resizemode-4,imgsize-29562/4-bitcoin-gold.jpg",
                         name: "Tesla",
                         code: "(TSLA)"),
            
            ContentStock(id: 2,
                         imageUrl: "https://img.etimg.com/thumb/msid-85584610,width-640,resizemode-4,imgsize-29562/4-bitcoin-gold.jpg",
                         name: "Amazon",
                         code: "(AMZN)"),
            
            ContentStock(id: 3,
                         imageUrl: "https://img.etimg.com/thumb/msid-85584610,width-640,resizemode-4,imgsize-29562/4-bitcoin-gold.jpg",
                         name: "AMD",
                         code: "(AMD)"),
            
            ContentStock(id: 4,
                         imageUrl: "https://img.etimg.com/thumb/msid-85584610,width-640,resizemode-4,imgsize-29562/4-bitcoin-gold.jpg",
                         name: "Facebook",
                         code: "(FB)"),
            
            ContentStock(id: 5,
                         imageUrl: "https://img.etimg.com/thumb/msid-85584610,width-640,resizemode-4,imgsize-29562/4-bitcoin-gold.jpg",
                         name: "Microsoft",
                         code: "(MRCF)"),
            
            ContentStock(id: 6,
                         imageUrl: "https://img.etimg.com/thumb/msid-85584610,width-640,resizemode-4,imgsize-29562/4-bitcoin-gold.jpg",
                         name: "Google",
                         code: "(GOOGLE)"),
            
            ContentStock(id: 7,
                         imageUrl: "https://img.etimg.com/thumb/msid-85584610,width-640,resizemode-4,imgsize-29562/4-bitcoin-gold.jpg",
                         name: "SpaceX",
                         code: "(SX)"),
        ])
    }
}
