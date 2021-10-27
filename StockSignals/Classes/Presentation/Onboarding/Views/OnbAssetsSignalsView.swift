//
//  OnbAssetsSignalsView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 27.10.2021.
//

import UIKit

final class OnbAssetsSignalsView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var stocksCell = makeCell(tag: 1, title: "Onboarding.AssetsSignals.Stocks".localized)
    lazy var optionsCell = makeCell(tag: 2, title: "Onboarding.AssetsSignals.Options".localized)
    lazy var cryptoCell = makeCell(tag: 3, title: "Onboarding.AssetsSignals.Crypto".localized)
    lazy var button = makeButton()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
        initialize()
        changeEnabled()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OnbAssetsSignalsView {
    func initialize() {
        backgroundColor = UIColor.clear
    }
    
    @objc
    func tapped(sender: Any) {
        guard let cell = sender as? OnbSelectCell else {
            return
        }

        cell.isSelect.toggle()

        changeEnabled()
    }
    
    func changeEnabled() {
        let hasSelected = [stocksCell, optionsCell, cryptoCell].contains { $0.isSelect }
        
        button.isEnabled = hasSelected
        button.alpha = hasSelected ? 1 : 0.6
    }
}

// MARK: Make constraints
private extension OnbAssetsSignalsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 145.scale : 90.scale)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            stocksCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            stocksCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            stocksCell.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            optionsCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            optionsCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            optionsCell.topAnchor.constraint(equalTo: stocksCell.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            cryptoCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            cryptoCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            cryptoCell.topAnchor.constraint(equalTo: optionsCell.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            button.heightAnchor.constraint(equalToConstant: 60.scale),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -57.scale : -30.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OnbAssetsSignalsView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 32.scale))
            .lineHeight(38.4.scale)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.AssetsSignals.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSubTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white.withAlphaComponent(0.4))
            .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
            .lineHeight(23.8.scale)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.AssetsSignals.SubTitle".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCell(tag: Int, title: String) -> OnbSelectCell {
        let view = OnbSelectCell()
        view.tag = tag
        view.title = title
        view.isSelect = false
        view.layer.cornerRadius = 16.scale
        view.layer.borderWidth = 1.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(tapped(sender:)), for: .touchUpInside)
        addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
        
        let view = UIButton()
        view.backgroundColor = UIColor(integralRed: 62, green: 89, blue: 223)
        view.layer.cornerRadius = 16.scale
        view.setAttributedTitle("Onboarding.Next".localized.attributed(with: attrs), for: .normal)
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
