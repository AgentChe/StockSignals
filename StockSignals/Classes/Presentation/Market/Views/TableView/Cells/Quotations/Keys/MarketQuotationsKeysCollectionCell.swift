//
//  MarketQuotationsCollectionCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 01.12.2021.
//

import UIKit

final class MarketQuotationsKeysCollectionCell: UICollectionViewCell {
    lazy var container = makeContainer()
    lazy var label = makeLabel()
    
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
extension MarketQuotationsKeysCollectionCell {
    static func width(for text: String) -> CGFloat {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 15.scale))
            .lineHeight(18.scale)
            .textAlignment(.center)
        let string = text.attributed(with: attrs)
        let width = string.size().width + 32.scale
        return width
    }
    
    func setup(element: MarketQuotationsKeysCollectionElement) {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 15.scale))
            .lineHeight(18.scale)
            .textAlignment(.center)
        label.attributedText = element.title.attributed(with: attrs)
        
        container.backgroundColor = element.isSelected ? UIColor(integralRed: 62, green: 89, blue: 223) : UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
    }
}

// MARK: Private
private extension MarketQuotationsKeysCollectionCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectedView
    }
}

// MARK: Make constraints
private extension MarketQuotationsKeysCollectionCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension MarketQuotationsKeysCollectionCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 10.scale
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
