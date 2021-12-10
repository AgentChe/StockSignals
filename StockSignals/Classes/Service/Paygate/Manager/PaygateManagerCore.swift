//
//  PaygateManagerCore.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.12.2021.
//

import RxSwift

final class PaygateManagerCore: PaygateManager {}

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
}
