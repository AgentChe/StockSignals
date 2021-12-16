//
//  PreparePaygatePrices.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.12.2021.
//

final class PreparePaygatePrices {
    static func prepare(prices: [ProductPrice], transfer: Paygate) -> Paygate? {
        guard transfer.options.count == 3 else {
            return nil
        }
        
        let options = transfer.options
        
        guard
            let firstOptionPrice = prices.first(where: { $0.id == options[0].productId }),
            let secondOptionPrice = prices.first(where: { $0.id == options[1].productId }),
            let thirdOptionPrice = prices.first(where: { $0.id == options[2].productId })
        else {
            return nil
        }
        
        return Paygate(headlineTop: transfer.headlineTop,
                       headlineBottom: transfer.headlineBottom,
                       options: [
                        makeOption(transfer: options[0], price: firstOptionPrice),
                        makeOption(transfer: options[1], price: secondOptionPrice),
                        makeOption(transfer: options[2], price: thirdOptionPrice)
                       ])
    }
}

// MARK: Private
private extension PreparePaygatePrices {
    static func makeOption(transfer: PaygateOption, price: ProductPrice) -> PaygateOption {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = price.priceLocale
        formatter.maximumFractionDigits = price.priceValue.truncatingRemainder(dividingBy: 1) > 0 ? 2 : 0
        
        let priceLocalized = formatter.string(from: NSNumber(value: price.priceValue)) ?? ""
        
        let title = transfer.title.replacingOccurrences(of: "@price", with: priceLocalized)
        let caption = transfer.caption.replacingOccurrences(of: "@price", with: priceLocalized)
        let subCaption = transfer.subCaption.replacingOccurrences(of: "@price", with: priceLocalized)
        
        return PaygateOption(productId: transfer.productId,
                             title: title,
                             caption: caption,
                             subCaption: subCaption,
                             buttonCaption: transfer.buttonCaption,
                             buttonSubCaption: transfer.buttonSubCaption)
    }
}
