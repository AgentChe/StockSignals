//
//  DetailsSocketManager.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 25.11.2021.
//

import Starscream
import RxSwift

final class DetailsSocketManager {
    struct Bundle {
        let preMarket: DetailsPreMarket?
        let primary: DetailsPreMarket?
    }
    
    deinit {
        socket.disconnect()
    }
    
    lazy var bundle = makeBundle().share(replay: 1, scope: .forever)
    
    private lazy var socket: WebSocket = {
        let url = URL(string: "wss://signals.awesum-apps.com/ws")!
        let request = URLRequest(url: url)
        return WebSocket(request: request)
    }()
    
    private let symbol: String
    
    init(symbol: String) {
        self.symbol = symbol
    }
}

// MARK: Private
private extension DetailsSocketManager {
    func makeBundle() -> Observable<Bundle> {
        defer {
            socket.connect()
        }
        
        return Observable<Bundle>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            self.socket.onEvent = { event in
                switch event {
                case .connected:
                    self.subscribe()
                case .text(let text):
                    guard let bundle = self.map(text: text) else {
                        return
                    }
                    
                    observer.onNext(bundle)
                default:
                    break
                }
            }
            
            return Disposables.create()
        }
    }
    
    func subscribe() {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return
        }
        
        let json = [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken,
            "subscribe": [symbol]
        ].jsonString()!

        socket.write(string: json)
    }
    
    func map(text: String) -> Bundle? {
        guard
            let jsonData = text.data(using: .utf8),
            let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
            let body = json["body"] as? [String: Any]
        else {
            return nil
        }
        
        let preMarketJSON = body["pre_market"] as? [String: Any] ?? [:]
        let preMarket = GetDetailsResponse.map(preMarket: preMarketJSON)
        
        let primaryJSON = body["primary"] as? [String: Any] ?? [:]
        let primary = GetDetailsResponse.map(preMarket: primaryJSON)
        
        return Bundle(preMarket: preMarket, primary: primary)
    }
}
