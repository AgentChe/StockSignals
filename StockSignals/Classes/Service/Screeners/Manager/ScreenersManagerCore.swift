//
//  ScreenersManagerCore.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.11.2021.
//

import RxSwift

final class ScreenersManagerCore: ScreenersManager {}

// MARK: ScreenersManager
extension ScreenersManagerCore {
    // TODO
    func obtainBundle(type: String) -> Single<ScreenersBundle?> {
        .deferred { .just(Self.mock()) }
//        guard let userToken = SessionManagerCore().getSession()?.userToken else {
//            return .error(SignError.tokenNotFound)
//        }
//
//        let request = GetScreenersBundleRequest(userToken: userToken, type: type)
//
//        return SDKStorage.shared
//            .restApiTransport
//            .callServerApi(requestBody: request)
//            .map { GetScreenersBundleResponse.map(from: $0) }
    }
}

// TODO: Remove
private extension ScreenersManagerCore {
    static func mock() -> ScreenersBundle {
        return ScreenersBundle(movers: mockMovers(),
                               screeners: mockScreeners())
    }
    
    static func mockMovers() -> [Mover] {
        let titles = [
            "Most Active", "New Low", "Unusual volume", "Most Volatile", "Top losers", "Top Gainers"
        ]
        let symbols = ["CEI", "SBEV", "ARYD", "HLBZ", "GROM", "BLT"]
        
        func make() -> Mover {
            Mover(title: titles.randomElement()!,
                  symbol: symbols.randomElement()!,
                  change: Double.random(in: -15...100))
        }
        
        var result = [Mover]()
        
        for _ in 0...40 {
            let mover = make()
            result.append(mover)
        }
        
        return result
    }
    
    static func mockScreeners() -> [Screener] {
        let symbols = ["SFIX", "AAPL", "APL", "GGL", "MRC", "FB"]
        let company = ["Apple", "Electronic Inc", "Google", "MicroSoft", "Facebook"]
        
        func makeStock() -> StockSignal {
            return StockSignal(imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png",
                               symbol: symbols.randomElement()!,
                               company: company.randomElement()!,
                               maxGain: Double.random(in: 0...100),
                               created: 1638183667,
                               type: .working,
                               risk: nil,
                               targetBuy: Double.random(in: -100...100),
                               targetSell: Double.random(in: -100...100),
                               targetStop: Double.random(in: -100...100),
                               note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target")
        }
        
        func makeOptionCrypto() -> OptionCryptoSignal {
            return OptionCryptoSignal(imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png",
                                      symbol: symbols.randomElement()!,
                                      description: "AAPL 10/15/2021 145P",
                                      created: 1638183667,
                                      type: .working,
                                      maxGain: Double.random(in: 0...100),
                                      targetBuy: Double.random(in: -100...100),
                                      targetStop: Double.random(in: -100...100),
                                      targetSell: [Double.random(in: -100...100), Double.random(in: -100...100)],
                                      note: "Scale out when above 25% profit, ideal buy zone within 10% of recommended Buy Target")
        }
        
        let keys = ["top_gainers", "top_losers", "unusual_volume", "pe"]
        let values = ["Top Gainers", "Top Losers", "Unusual Volume", "P/E"]
        
        func make() -> Screener {
            let index = Int.random(in: 0...(keys.count - 1))
            
            var optionCryptoSignals = [OptionCryptoSignal]()
            for _ in 0...10 {
                let signal = makeOptionCrypto()
                optionCryptoSignals.append(signal)
            }
            
            var stockSignals = [StockSignal]()
            for _ in 0...10 {
                let signal = makeStock()
                stockSignals.append(signal)
            }
            
            return Screener(key: keys[index],
                            value: values[index],
                            optionCryptoSignals: optionCryptoSignals,
                            stockSignals: stockSignals)
        }
        
        var result = [Screener]()
        
        for _ in 0...40 {
            let screener = make()
            result.append(screener)
        }
        
        return result
    }
}
