//
//  AllSignalsTableStockCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.11.2021.
//

import UIKit
import Kingfisher

final class AllSignalsTableStockCell: UITableViewCell {
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
    lazy var lockView = makeLockView()
    lazy var lockLabel = makeLockLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension AllSignalsTableStockCell {
    func setup(element: AllSignalsTableSSignal) {
        let signal = element.signal
        
        iconView.kf.cancelDownloadTask()
        iconView.image = nil
        
        if let url = URL(string: signal.imageUrl) {
            iconView.kf.setImage(with: url)
        }
        
        symbolLabel.attributedText = signal.symbol
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        
        let date = Date(timeIntervalSince1970: signal.created)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy HH:mm:ss"
        let created = formatter.string(from: date)
        createdLabel.attributedText = created
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.4))
                            .font(Fonts.SFProDisplay.regular(size: 13.scale))
                            .lineHeight(15.6.scale)
                            .textAlignment(.left))
        
        companyLabel.attributedText = signal.company
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.4))
                            .font(Fonts.SFProDisplay.regular(size: 13.scale))
                            .lineHeight(15.6.scale))
        
        let maxGain = String(signal.maxGain) + "%"
        maxGainLabel.attributedText = maxGain
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 112, green: 226, blue: 248))
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(23.8.scale))
        
        let buyTarget = "$" + String(signal.targetBuy)
        buyTargetLabel.attributedText = buyTarget
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        
        
        var stopLoss: String?
        if let value = signal.targetStop {
            stopLoss = "$" + String(value)
        }
        stopLossLabel.attributedText = stopLoss?
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        stopLossEmptyPlaceholder.isHidden = signal.targetStop != nil
        
        let sellTarget = "$" + String(signal.targetSell)
        sellTargetLabel.attributedText = sellTarget
            .attributed(with: TextAttributes()
                            .textColor(signal.targetSell > 0 ? UIColor(integralRed: 129, green: 232, blue: 129) : UIColor(integralRed: 235, green: 96, blue: 42))
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        
        riskLabel.attributedText = signal.risk?
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        riskEmptyPlaceholder.isHidden = signal.risk != nil
        
        noteLabel.attributedText = signal.note?
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.4))
                            .font(Fonts.SFProDisplay.regular(size: 13.scale)))
        
        lockView.isHidden = !element.isLocked
        lockLabel.isHidden = !element.isLocked
    }
}

// MARK: Private
private extension AllSignalsTableStockCell {
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
private extension AllSignalsTableStockCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
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
        
        NSLayoutConstraint.activate([
            lockView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            lockView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            lockView.topAnchor.constraint(equalTo: contentView.topAnchor),
            lockView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            lockLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            lockLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension AllSignalsTableStockCell {
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
    
    func makeLockView() -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.layer.cornerRadius = 20.scale
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLockLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
            .lineHeight(22.8.scale)
            .textAlignment(.center)

        let view = UILabel()
        view.attributedText = "Signals.All.Unlock".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
