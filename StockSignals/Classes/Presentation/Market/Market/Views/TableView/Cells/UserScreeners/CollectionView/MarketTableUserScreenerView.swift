//
//  MarketTableUserScreenerView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 06.12.2021.
//

import UIKit
import Kingfisher

final class MarketTableUserScreenerView: UIView {
    lazy var iconView = makeIconView()
    lazy var symbolLabel = makeLabel()
    lazy var companyLabel = makeLabel()
    lazy var priceLabel = makeLabel()
    lazy var changeLabel = makeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension MarketTableUserScreenerView {
    func setup(element: Quotation?) {
        iconView.kf.cancelDownloadTask()
        iconView.image = nil
        
        if let path = element?.imageUrl, let url = URL(string: path) {
            iconView.kf.setImage(with: url)
        }
        
        symbolLabel.attributedText = element?.symbol
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.bold(size: 15.scale))
                            .lineHeight(21.scale))
        
        companyLabel.attributedText = element?.company
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.4))
                            .font(Fonts.SFProDisplay.regular(size: 13.scale))
                            .lineHeight(15.6.scale))
        
        priceLabel.attributedText = price(element: element)?
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        
        changeLabel.attributedText = change(element: element)
    }
}

// MARK: Private
private extension MarketTableUserScreenerView {
    func price(element: Quotation?) -> String? {
        guard let element = element else {
            return nil
        }
        
        return "$" + String(element.price)
    }
    
    func change(element: Quotation?) -> NSAttributedString? {
        guard let element = element else {
            return nil
        }
        
        let color = element.change > 0 ? UIColor(integralRed: 129, green: 232, blue: 129) : UIColor(integralRed: 235, green: 96, blue: 42)
        
        let string = String(element.change) + "%"
        
        let attrs = TextAttributes()
            .textColor(color)
            .font(Fonts.SFProDisplay.bold(size: 17.scale))
            .lineHeight(20.4.scale)
        
        return string.attributed(with: attrs)
    }
}

// MARK: Make constraints
private extension MarketTableUserScreenerView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 48.scale),
            iconView.heightAnchor.constraint(equalToConstant: 48.scale),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.scale),
            iconView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            symbolLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 76.scale),
            symbolLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90.scale),
            symbolLabel.topAnchor.constraint(equalTo: topAnchor, constant: 3.5.scale)
        ])
        
        NSLayoutConstraint.activate([
            companyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 76.scale),
            companyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90.scale),
            companyLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.scale),
            priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 3.5.scale)
        ])
        
        NSLayoutConstraint.activate([
            changeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.scale),
            changeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension MarketTableUserScreenerView {
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
