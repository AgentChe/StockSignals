//
//  MarketQuotationsCollectionCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 01.12.2021.
//

import UIKit
import Kingfisher

final class MarketQuotationsCollectionCell: UICollectionViewCell {
    lazy var container = makeContainer()
    lazy var iconView = makeIconView()
    lazy var symbolLabel = makeLabel()
    lazy var priceLabel = makeLabel()
    lazy var changeLabel = makeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension MarketQuotationsCollectionCell {
    func setup(element: Quotation) {
        iconView.kf.cancelDownloadTask()
        iconView.image = nil
        
        if let path = element.imageUrl, let url = URL(string: path) {
            iconView.kf.setImage(with: url)
        }
        
        symbolLabel.attributedText = element.symbol
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        
        priceLabel.attributedText = String(element.price)
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.4))
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        
        let change = String(element.change) + "%"
        changeLabel.attributedText = change
            .attributed(with: TextAttributes()
                            .textColor(element.change > 0 ? UIColor(integralRed: 129, green: 232, blue: 129) : UIColor(integralRed: 235, green: 96, blue: 42))
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
    }
}

// MARK: Private
private extension MarketQuotationsCollectionCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectedView
    }
}

// MARK: Make constraints
private extension MarketQuotationsCollectionCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 48.scale),
            iconView.heightAnchor.constraint(equalToConstant: 48.scale),
            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            iconView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            symbolLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            symbolLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 76.scale)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            priceLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 109.scale)
        ])
        
        NSLayoutConstraint.activate([
            changeLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            changeLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 109.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension MarketQuotationsCollectionCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 20.scale
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 20.scale
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
