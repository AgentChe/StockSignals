//
//  PaygateReviewsCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 14.12.2021.
//

import UIKit

final class PaygateReviewsCell: UICollectionViewCell {
    lazy var container = makeContainer()
    lazy var iconView = makeImageView()
    lazy var starsView = makeStarsView()
    lazy var textLabel = makeLabel()
    lazy var nameLabel = makeLabel()
    
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
extension PaygateReviewsCell {
    func setup(element: PaygateReviewsElement) {
        iconView.image = UIImage(named: element.image)
        
        starsView.stars = element.stars
        
        nameLabel.attributedText = element.name
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.4))
                            .font(Fonts.SFProDisplay.regular(size: 13.scale))
                            .lineHeight(18.2.scale))
        
        textLabel.attributedText = element.text
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.regular(size: 15.scale))
                            .lineHeight(18.scale))
    }
}

// MARK: Private
private extension PaygateReviewsCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectedView
    }
}

// MARK: Make constraints
private extension PaygateReviewsCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 32.scale),
            iconView.heightAnchor.constraint(equalToConstant: 32.scale),
            iconView.topAnchor.constraint(equalTo: container.topAnchor, constant: 10.scale),
            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            starsView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 56.scale),
            starsView.topAnchor.constraint(equalTo: container.topAnchor, constant: 11.scale),
            starsView.heightAnchor.constraint(equalToConstant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 56.scale),
            nameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12.scale),
            nameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 25.scale)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            textLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            textLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension PaygateReviewsCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57)
        view.layer.cornerRadius = 16.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeStarsView() -> PaygateReviewStarsView {
        let view = PaygateReviewStarsView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
