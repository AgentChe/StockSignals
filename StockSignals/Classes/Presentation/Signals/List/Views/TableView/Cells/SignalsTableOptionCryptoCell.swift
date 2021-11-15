//
//  SignalsTableOptionCryptoCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.11.2021.
//

import UIKit
import Kingfisher

final class SignalsTableOptionCryptoCell: UITableViewCell {
    lazy var container = makeContainer()
    lazy var iconView = makeIconView()
    lazy var symbolLabel = makeValueLabel()
    lazy var descrLabel = makeValueLabel()
    lazy var createdLabel = makeValueLabel()
    lazy var buyTargetTitleLabel = makeTitleLabel(title: "Signals.BuyTarget".localized)
    lazy var buyTargetLabel = makeValueLabel()
    lazy var stopLossTitleLabel = makeTitleLabel(title: "Signals.StopLoss".localized)
    lazy var stopLossLabel = makeValueLabel()
    lazy var stopLossEmptyPlaceholder = makeEmptyPlaceholder()
    lazy var maxGainTitleLabel = makeTitleLabel(title: "Signals.MaxGain".localized)
    lazy var maxGainLabel = makeValueLabel()
    lazy var target1stTitleLabel = makeTitleLabel(title: "Signals.1stTarget")
    lazy var target1stLabel = makeValueLabel()
    lazy var target1stEmptyPlaceholder = makeEmptyPlaceholder()
    lazy var target2ndTitleLabel = makeTitleLabel(title: "Signals.2ndTarget")
    lazy var target2ndLabel = makeValueLabel()
    lazy var target2ndEmptyPlaceholder = makeEmptyPlaceholder()
    lazy var target3rdTitleLabel = makeTitleLabel(title: "Signals.3rdTarget")
    lazy var target3rdLabel = makeValueLabel()
    lazy var target3rdEmptyPlaceholder = makeEmptyPlaceholder()
    lazy var noteLabel = makeValueLabel()
    
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
extension SignalsTableOptionCryptoCell {
    func setup(element: OptionCryptoSignal) {
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
        
        descrLabel.attributedText = element.description
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.regular(size: 13.scale))
                            .lineHeight(15.6.scale))
        
        let date = Date(timeIntervalSince1970: element.created)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let dateString = formatter.string(from: date)
        formatter.dateFormat = "HH:mm:ss"
        let timeString = formatter.string(from: date)
        let created = String(format: "%@\n%@", dateString, timeString)
        createdLabel.attributedText = created
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.4))
                            .font(Fonts.SFProDisplay.regular(size: 13.scale))
                            .lineHeight(18.2.scale)
                            .textAlignment(.right))
        
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
        
        let maxGain = String(element.maxGain) + "%"
        maxGainLabel.attributedText = maxGain
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 112, green: 226, blue: 248))
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(23.8.scale))
        
        target1stLabel.text = nil
        if element.targetSell.indices.contains(0) {
            let target1st = element.targetSell[0]
            let string = "$" + String(target1st)
            target1stLabel.attributedText = string
                .attributed(with: TextAttributes()
                                .textColor(target1st > 0 ? UIColor(integralRed: 129, green: 232, blue: 129) : UIColor(integralRed: 235, green: 96, blue: 42))
                                .font(Fonts.SFProDisplay.bold(size: 17.scale))
                                .lineHeight(20.4.scale))
        }
        target1stEmptyPlaceholder.isHidden = element.targetSell.indices.contains(0)
        
        target2ndLabel.text = nil
        if element.targetSell.indices.contains(1) {
            let target2nd = element.targetSell[1]
            let string = "$" + String(target2nd)
            target2ndLabel.attributedText = string
                .attributed(with: TextAttributes()
                                .textColor(target2nd > 0 ? UIColor(integralRed: 129, green: 232, blue: 129) : UIColor(integralRed: 235, green: 96, blue: 42))
                                .font(Fonts.SFProDisplay.bold(size: 17.scale))
                                .lineHeight(20.4.scale))
        }
        target2ndEmptyPlaceholder.isHidden = element.targetSell.indices.contains(1)
        
        target3rdLabel.text = nil
        if element.targetSell.indices.contains(2) {
            let target3rd = element.targetSell[2]
            let string = "$" + String(target3rd)
            target3rdLabel.attributedText = string
                .attributed(with: TextAttributes()
                                .textColor(target3rd > 0 ? UIColor(integralRed: 129, green: 232, blue: 129) : UIColor(integralRed: 235, green: 96, blue: 42))
                                .font(Fonts.SFProDisplay.bold(size: 17.scale))
                                .lineHeight(20.4.scale))
        }
        target3rdEmptyPlaceholder.isHidden = element.targetSell.indices.contains(2)
        
        noteLabel.attributedText = element.note?
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.4))
                            .font(Fonts.SFProDisplay.regular(size: 13.scale)))
    }
}

// MARK: Private
private extension SignalsTableOptionCryptoCell {
    func initialize() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    func target1st(from: OptionCryptoSignal) -> Double? {
        nil
    }
    
    func target2nd(from: OptionCryptoSignal) -> Double? {
        nil
    }
    
    func target3rd(from: OptionCryptoSignal) -> Double? {
        nil
    }
}

// MARK: Make constraints
private extension SignalsTableOptionCryptoCell {
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
            createdLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            createdLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            descrLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 64.scale),
            descrLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 4.scale)
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
            target1stTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            target1stTitleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            target1stLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            target1stLabel.topAnchor.constraint(equalTo: target1stTitleLabel.bottomAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            target1stEmptyPlaceholder.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            target1stEmptyPlaceholder.topAnchor.constraint(equalTo: target1stTitleLabel.bottomAnchor, constant: 4.scale),
            target1stEmptyPlaceholder.heightAnchor.constraint(equalToConstant: 21.scale),
            target1stEmptyPlaceholder.widthAnchor.constraint(equalToConstant: 142.scale)
        ])
        
        NSLayoutConstraint.activate([
            stopLossTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            stopLossTitleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 69.scale)
        ])
        
        NSLayoutConstraint.activate([
            stopLossLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            stopLossLabel.topAnchor.constraint(equalTo: stopLossTitleLabel.bottomAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            stopLossEmptyPlaceholder.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            stopLossEmptyPlaceholder.widthAnchor.constraint(equalToConstant: 142.scale),
            stopLossEmptyPlaceholder.topAnchor.constraint(equalTo: stopLossTitleLabel.bottomAnchor, constant: 4.scale),
            stopLossEmptyPlaceholder.heightAnchor.constraint(equalToConstant: 21.scale)
        ])
        
        NSLayoutConstraint.activate([
            target2ndTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            target2ndTitleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 69.scale)
        ])
        
        NSLayoutConstraint.activate([
            target2ndLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            target2ndLabel.topAnchor.constraint(equalTo: target2ndTitleLabel.bottomAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            target2ndEmptyPlaceholder.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            target2ndEmptyPlaceholder.topAnchor.constraint(equalTo: target2ndTitleLabel.bottomAnchor, constant: 4.scale),
            target2ndEmptyPlaceholder.heightAnchor.constraint(equalToConstant: 21.scale),
            target2ndEmptyPlaceholder.widthAnchor.constraint(equalToConstant: 142.scale)
        ])
        
        NSLayoutConstraint.activate([
            maxGainTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            maxGainTitleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 122.scale)
        ])
        
        NSLayoutConstraint.activate([
            maxGainLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            maxGainLabel.topAnchor.constraint(equalTo: maxGainTitleLabel.bottomAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            target3rdTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            target3rdTitleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 122.scale)
        ])
        
        NSLayoutConstraint.activate([
            target3rdLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            target3rdLabel.topAnchor.constraint(equalTo: target3rdTitleLabel.bottomAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            target3rdEmptyPlaceholder.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 173.scale),
            target3rdEmptyPlaceholder.topAnchor.constraint(equalTo: target3rdTitleLabel.bottomAnchor, constant: 4.scale),
            target3rdEmptyPlaceholder.heightAnchor.constraint(equalToConstant: 21.scale),
            target3rdEmptyPlaceholder.widthAnchor.constraint(equalToConstant: 142.scale)
        ])
        
        NSLayoutConstraint.activate([
            noteLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            noteLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            noteLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 236.scale),
            noteLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension SignalsTableOptionCryptoCell {
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
