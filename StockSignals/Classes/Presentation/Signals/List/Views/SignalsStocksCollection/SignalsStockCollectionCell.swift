//
//  SignalsStockCollectionCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.11.2021.
//

import UIKit
import Kingfisher

final class SignalsStockCollectionCell: UICollectionViewCell {
    lazy var container = makeContainer()
    lazy var iconView = makeIconView()
    lazy var symbolLabel = makeSymbolLabel()
    lazy var createdLabel = makeCreatedLabel()
    lazy var maxGainTitleLabel = makeMaxGainTitleLabel()
    lazy var companyLabel = makeValueLabel()
    lazy var maxGainLabel = makeValueLabel()
    lazy var buyTargetTitleLabel = makeTitleLabel(title: "Signals.BuyTarget".localized)
    lazy var buyTargetLabel = makeValueLabel()
    lazy var stopLossTitleLabel = makeTitleLabel(title: "Signals.StopLoss".localized)
    lazy var stopLossLabel = makeValueLabel()
    lazy var stopLossEmptyPlaceholder = makeEmptyPlaceholder()
    lazy var sellTargetTitleLabel = makeTitleLabel(title: "Signals.SellTarget".localized)
    lazy var sellTargetLabel = makeValueLabel()
    lazy var riskTitleLabel = makeTitleLabel(title: "Signals.Risk".localized)
    lazy var riskLabel = makeValueLabel()
    lazy var noteLabel = makeNoteLabel()
    lazy var riskEmptyPlaceholder = makeEmptyPlaceholder()
    
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
extension SignalsStockCollectionCell {
    func setup(element: StockSignal) {
        iconView.kf.cancelDownloadTask()
        iconView.image = nil
        
        if let url = URL(string: element.imageUrl) {
            iconView.kf.setImage(with: url)
        }
        
        symbolLabel.attributedText = element.symbol
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        
        let date = Date(timeIntervalSince1970: element.created)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy HH:mm:ss"
        let created = formatter.string(from: date)
        createdLabel.attributedText = created
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.4))
                            .font(Fonts.SFProDisplay.regular(size: 13.scale))
                            .lineHeight(15.6.scale)
                            .textAlignment(.left))
        
        companyLabel.attributedText = element.company
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.4))
                            .font(Fonts.SFProDisplay.regular(size: 13.scale))
                            .lineHeight(15.6.scale))
        
        let maxGain = String(element.maxGain) + "%"
        maxGainLabel.attributedText = maxGain
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 112, green: 226, blue: 248))
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(23.8.scale))
        
        let buyTarget = "$" + String(element.targetBuy)
        buyTargetLabel.attributedText = buyTarget
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        
        
        var stopLoss: String?
        if let value = element.targetStop {
            stopLoss = "$" + String(value)
        }
        stopLossLabel.attributedText = stopLoss?
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        stopLossEmptyPlaceholder.isHidden = element.targetStop != nil
        
        let sellTarget = "$" + String(element.targetSell)
        sellTargetLabel.attributedText = sellTarget
            .attributed(with: TextAttributes()
                            .textColor(element.targetSell > 0 ? UIColor(integralRed: 129, green: 232, blue: 129) : UIColor(integralRed: 235, green: 96, blue: 42))
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        
        riskLabel.attributedText = element.risk?
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        riskEmptyPlaceholder.isHidden = element.risk != nil
        
        noteLabel.attributedText = element.note?
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.4))
                            .font(Fonts.SFProDisplay.regular(size: 13.scale)))
    }
}

// MARK: Private
private extension SignalsStockCollectionCell {
    func initialize() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectedView
        
        noteLabel.numberOfLines = 2
    }
}

// MARK: Make constraints
private extension SignalsStockCollectionCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 40.scale),
            iconView.heightAnchor.constraint(equalToConstant: 40.scale),
            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            iconView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            symbolLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 64.scale),
            symbolLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            createdLabel.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 6.scale),
            createdLabel.centerYAnchor.constraint(equalTo: symbolLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            maxGainTitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            maxGainTitleLabel.centerYAnchor.constraint(equalTo: symbolLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            companyLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 64.scale),
            companyLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            maxGainLabel.centerXAnchor.constraint(equalTo: maxGainTitleLabel.centerXAnchor),
            maxGainLabel.topAnchor.constraint(equalTo: maxGainTitleLabel.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            buyTargetTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            buyTargetTitleLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            buyTargetLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            buyTargetLabel.topAnchor.constraint(equalTo: buyTargetTitleLabel.bottomAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            stopLossTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            stopLossTitleLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            stopLossLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            stopLossLabel.topAnchor.constraint(equalTo: stopLossTitleLabel.bottomAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            stopLossEmptyPlaceholder.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            stopLossEmptyPlaceholder.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            stopLossEmptyPlaceholder.topAnchor.constraint(equalTo: stopLossTitleLabel.bottomAnchor, constant: 4.scale),
            stopLossEmptyPlaceholder.heightAnchor.constraint(equalToConstant: 21.scale)
        ])
        
        NSLayoutConstraint.activate([
            sellTargetTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            sellTargetTitleLabel.topAnchor.constraint(equalTo: buyTargetLabel.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            sellTargetLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            sellTargetLabel.topAnchor.constraint(equalTo: sellTargetTitleLabel.bottomAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            riskTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            riskTitleLabel.topAnchor.constraint(equalTo: stopLossTitleLabel.bottomAnchor, constant: 37.scale)
        ])
        
        NSLayoutConstraint.activate([
            riskLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            riskLabel.topAnchor.constraint(equalTo: riskTitleLabel.bottomAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            riskEmptyPlaceholder.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            riskEmptyPlaceholder.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            riskEmptyPlaceholder.topAnchor.constraint(equalTo: riskTitleLabel.bottomAnchor, constant: 4.scale),
            riskEmptyPlaceholder.heightAnchor.constraint(equalToConstant: 21.scale)
        ])
        
        NSLayoutConstraint.activate([
            noteLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            noteLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            noteLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 183.scale),
            noteLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension SignalsStockCollectionCell {
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
    
    func makeSymbolLabel() -> UILabel {
        let view = UILabel()
        view.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeCreatedLabel() -> UILabel {
        let view = UILabel()
        view.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeMaxGainTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white.withAlphaComponent(0.4))
            .font(Fonts.SFProDisplay.regular(size: 13.scale))
            .lineHeight(18.2.scale)
        
        let view = UILabel()
        view.attributedText = "Signals.MaxGain".localized.attributed(with: attrs)
        view.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeTitleLabel(title: String) -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white.withAlphaComponent(0.4))
            .font(Fonts.SFProDisplay.regular(size: 13.scale))
            .lineHeight(15.6.scale)
        
        let view = UILabel()
        view.attributedText = title.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeValueLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeNoteLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeEmptyPlaceholder() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 6.scale
        view.backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
