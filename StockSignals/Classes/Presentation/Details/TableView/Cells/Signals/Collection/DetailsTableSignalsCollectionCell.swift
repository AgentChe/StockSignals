//
//  DetailsTableSignalsCollectionCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 16.11.2021.
//

import UIKit
import Kingfisher

final class DetailsTableSignalsCollectionCell: UICollectionViewCell {
    lazy var container = makeContainer()
    lazy var iconView = makeIconView()
    lazy var symbolLabel = makeValueLabel()
    lazy var companyLabel = makeValueLabel()
    lazy var createdLabel = makeValueLabel()
    lazy var maxGainTitleLabel = makeTitleLabel(title: "Signals.MaxGain".localized)
    lazy var maxGainLabel = makeValueLabel()
    lazy var buyTargetTitleLabel = makeTitleLabel(title: "Details.Signals.BuyTarget".localized)
    lazy var buyTargetLabel = makeValueLabel()
    lazy var stopLossTitleLabel = makeTitleLabel(title: "Details.Signals.StopLoss".localized)
    lazy var stopLossLabel = makeValueLabel()
    lazy var stopLossEmptyPlaceholder = makeEmptyPlaceholder()
    lazy var sellTitleLabel = makeTitleLabel(title: "Details.Signals.SellTarget")
    lazy var sellLabel = makeValueLabel()
    lazy var noteLabel = makeValueLabel()
    
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
extension DetailsTableSignalsCollectionCell {
    func setup(element: DetailsTableSignal) {
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
        
        companyLabel.attributedText = element.company?
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.4))
                            .font(Fonts.SFProDisplay.regular(size: 13.scale))
                            .lineHeight(15.6.scale))
        
        let date = Date(timeIntervalSince1970: element.created)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        let created = formatter.string(from: date)
        createdLabel.attributedText = created
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
        
        let buyTarget = "$" + String(element.buy)
        buyTargetLabel.attributedText = buyTarget
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        
        var stopLoss: String?
        if let value = element.stop {
            stopLoss = "$" + String(value)
        }
        stopLossLabel.attributedText = stopLoss?
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        stopLossEmptyPlaceholder.isHidden = element.stop != nil
        
        let sell = element.sells
            .map {  "$" + String($0) }
            .joined(separator: " / ")
        sellLabel.attributedText = sell
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 129, green: 232, blue: 129))
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        
        noteLabel.attributedText = element.note?
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.4))
                            .font(Fonts.SFProDisplay.regular(size: 13.scale)))
    }
}

// MARK: Private
private extension DetailsTableSignalsCollectionCell {
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
private extension DetailsTableSignalsCollectionCell {
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
            companyLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 64.scale),
            companyLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            createdLabel.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 6.scale),
            createdLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 20.scale)
        ])
        
        NSLayoutConstraint.activate([
            maxGainTitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            maxGainTitleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 20.scale)
        ])
        
        NSLayoutConstraint.activate([
            maxGainLabel.centerXAnchor.constraint(equalTo: maxGainTitleLabel.centerXAnchor),
            maxGainLabel.topAnchor.constraint(equalTo: maxGainTitleLabel.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            buyTargetTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            buyTargetTitleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            buyTargetLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            buyTargetLabel.topAnchor.constraint(equalTo: buyTargetTitleLabel.bottomAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            stopLossTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            stopLossTitleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            stopLossLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            stopLossLabel.topAnchor.constraint(equalTo: stopLossTitleLabel.bottomAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            stopLossEmptyPlaceholder.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            stopLossEmptyPlaceholder.widthAnchor.constraint(equalToConstant: 142.scale),
            stopLossEmptyPlaceholder.topAnchor.constraint(equalTo: stopLossTitleLabel.bottomAnchor, constant: 4.scale),
            stopLossEmptyPlaceholder.heightAnchor.constraint(equalToConstant: 21.scale)
        ])
        
        NSLayoutConstraint.activate([
            sellTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            sellTitleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 70.scale)
        ])
        
        NSLayoutConstraint.activate([
            sellLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            sellLabel.topAnchor.constraint(equalTo: sellTitleLabel.bottomAnchor, constant: 4.scale)
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
private extension DetailsTableSignalsCollectionCell {
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
