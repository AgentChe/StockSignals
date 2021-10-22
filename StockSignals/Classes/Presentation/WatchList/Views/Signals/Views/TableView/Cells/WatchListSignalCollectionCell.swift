//
//  WatchListSignalCollectionCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 22.10.2021.
//

import UIKit

final class WatchListSignalCollectionCell: UICollectionViewCell {
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
extension WatchListSignalCollectionCell {
    func setup(element: WatchListSignalCollectionElement) {
        var attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 15.scale))
            .textAlignment(.center)
            .lineHeight(18.scale)
        
        switch element {
        case .price(let price):
            attrs = attrs.textColor(price > 0 ? UIColor(integralRed: 129, green: 232, blue: 129) : UIColor(integralRed: 235, green: 96, blue: 42))
            let string = String(price)
            label.attributedText = string.attributed(with: attrs)
        case .change(let change):
            attrs = attrs.textColor(change > 0 ? UIColor(integralRed: 129, green: 232, blue: 129) : UIColor(integralRed: 235, green: 96, blue: 42))
            let string = String(change) + "%"
            label.attributedText = string.attributed(with: attrs)
        case .volume(let volume):
            label.attributedText = volume.attributed(with: attrs)
        case .peRatio(let peRatio):
            let string = String(peRatio) + "%"
            label.attributedText = string.attributed(with: attrs)
        case .marketCap(let marketCap):
            label.attributedText = marketCap.attributed(with: attrs)
        }
    }
}

// MARK: Private
private extension WatchListSignalCollectionCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectedView
    }
}

// MARK: Make constraints
private extension WatchListSignalCollectionCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

// MARK: Lazy initializattion
private extension WatchListSignalCollectionCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
