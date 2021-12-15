//
//  PaygateManagerCore.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.12.2021.
//

import RxSwift

final class PaygateManagerCore: PaygateManager {
    enum Constants {
        static let configKey = "paygate_manager_core_config_key"
    }
}

// MARK: Public
extension PaygateManagerCore {
    func obtainPaygateTransfer() -> Single<Paygate?> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let usedProducts = SessionManagerCore().getSession()?.usedProducts
        
        let request = GetPaygateRequest(userToken: userToken, usedProducts: usedProducts)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetPaygateTransferResponse.transfer(from: $0) }
    }
    
    func preparePrices(for transfer: Paygate) -> Single<Paygate?> {
        SDKStorage.shared
            .iapManager
            .obtainProducts(ids: transfer.options.map { $0.productId })
            .map { iapProducts -> [ProductPrice] in
                iapProducts.map { ProductPrice(product: $0.product) }
            }
            .map { productPrices -> Paygate? in
                PreparePaygatePrices.prepare(prices: productPrices, transfer: transfer)
            }
    }
    
    func retrieveConfig(forceUpdate: Bool) -> Single<PaygateConfig?> {
        guard forceUpdate else {
            return .deferred { [weak self] in
                let config = self?.getConfig()
                return .just(config)
            }
        }
        
        let request = GetPaygateConfigRequest()
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetPaygateConfigResponse.map(from: $0) }
            .do(onSuccess: { config in
                guard let config = config, let data = try? JSONEncoder().encode(config) else {
                    return
                }
                
                UserDefaults.standard.set(data, forKey: Constants.configKey)
            })
    }
    
    func getConfig() -> PaygateConfig? {
        guard
            let data = UserDefaults.standard.data(forKey: Constants.configKey),
            let config = try? JSONDecoder().decode(PaygateConfig.self, from: data)
        else {
            return nil
        }
        
        return config
    }
}
