//
//  PaygateOptionView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.12.2021.
//

import UIKit

final class PaygateOptionView: UIButton {
    var isBestValue: Bool = false {
        didSet {
            updateBestMode()
        }
    }
    
    var isSelect: Bool = false {
        didSet {
            updateSelected()
        }
    }
    
    var option: PaygateOption? = nil {
        didSet {
            update()
        }
    }
    
    lazy var bestValueContainer = makeBestValueContainer()
    lazy var bestValueLabel = makeBestValueLabel()
    lazy var container = makeContainer()
    lazy var periodLabel = makeLabel()
    lazy var captionLabel = makeLabel()
    lazy var subCaptionLabel = makeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        updateBestMode()
        updateSelected()
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Make constraints
private extension PaygateOptionView {
    func updateBestMode() {
        bestValueContainer.isHidden = !isBestValue
        container.layer.maskedCorners = isBestValue ? [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] : [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func updateSelected() {
        container.layer.borderColor = isSelect ? UIColor(integralRed: 62, green: 89, blue: 223).cgColor : UIColor(integralRed: 53, green: 55, blue: 65).cgColor
    }
    
    func update() {
        periodLabel.attributedText = option?.title
            .attributed(with: TextAttributes()
                            .font(Fonts.SFProDisplay.semiBold(size: 13.scale))
                            .textColor(UIColor.white.withAlphaComponent(0.8))
                            .lineHeight(15.6.scale)
                            .textAlignment(.center))
        
        captionLabel.attributedText = option?.caption
            .attributed(with: TextAttributes()
                            .font(Fonts.SFProDisplay.bold(size: 26.scale))
                            .textColor(UIColor.white)
                            .lineHeight(32.1.scale)
                            .letterSpacing(-1.scale)
                            .textAlignment(.center))
        
        subCaptionLabel.attributedText = option?.subCaption
            .attributed(with: TextAttributes()
                            .font(Fonts.SFProDisplay.regular(size: 12.scale))
                            .textColor(UIColor.white.withAlphaComponent(0.4))
                            .lineHeight(14.4.scale)
                            .textAlignment(.center))
    }
}

// MARK: Make constraints
private extension PaygateOptionView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            bestValueContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            bestValueContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            bestValueContainer.heightAnchor.constraint(equalToConstant: 24.scale),
            bestValueContainer.bottomAnchor.constraint(equalTo: container.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bestValueLabel.centerXAnchor.constraint(equalTo: bestValueContainer.centerXAnchor),
            bestValueLabel.centerYAnchor.constraint(equalTo: bestValueContainer.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.heightAnchor.constraint(equalToConstant: 122.scale)
        ])
        
        NSLayoutConstraint.activate([
            periodLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            periodLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            periodLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            captionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            captionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            captionLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 43.scale)
        ])
        
        NSLayoutConstraint.activate([
            subCaptionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            subCaptionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            subCaptionLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 78.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension PaygateOptionView {
    func makeBestValueContainer() -> UIView {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor(integralRed: 62, green: 89, blue: 223)
        view.layer.cornerRadius = 12.scale
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeBestValueLabel() -> UILabel {
        let attrs = TextAttributes()
            .font(Fonts.SFProDisplay.bold(size: 13.scale))
            .textColor(UIColor.white)
            .lineHeight(15.6.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Paygate.BestValue".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        bestValueContainer.addSubview(view)
        return view
    }
    
    func makeContainer() -> UIView {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 12.scale
        view.layer.borderWidth = 2.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
