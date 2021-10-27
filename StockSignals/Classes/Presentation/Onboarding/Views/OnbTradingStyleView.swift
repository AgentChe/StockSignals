//
//  OnbTradingStyleView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 27.10.2021.
//

import UIKit

final class OnbTradingStyleView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var scalperCell = makeCell(tag: 1, title: "Onboarding.TradingStyle.Scalper".localized)
    lazy var dayTraderCell = makeCell(tag: 2, title: "Onboarding.TradingStyle.DayTrader".localized)
    lazy var swingTraderCell = makeCell(tag: 3, title: "Onboarding.TradingStyle.SwingTrader".localized)
    lazy var positionTraderCell = makeCell(tag: 4, title: "Onboarding.TradingStyle.PositionTrader".localized)
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
private extension OnbTradingStyleView {
    func initialize() {
        backgroundColor = UIColor.clear
    }
    
    @objc
    func tapped(sender: Any) {
        guard let cell = sender as? OnbSelectCell else {
            return
        }
        
        [
            scalperCell,
            dayTraderCell,
            swingTraderCell,
            positionTraderCell
        ].forEach { $0.isSelect = false }

        cell.isSelect = true

        changeEnabled()
    }
    
    func changeEnabled() {
        let hasSelected = [
            scalperCell,
            dayTraderCell,
            swingTraderCell,
            positionTraderCell
        ].contains(where: { $0.isSelect })
        
        button.isEnabled = hasSelected
        button.alpha = hasSelected ? 1 : 0.6
    }
}

// MARK: Make constraints
private extension OnbTradingStyleView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 145.scale : 90.scale)
        ])
        
        NSLayoutConstraint.activate([
            scalperCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            scalperCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            scalperCell.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            dayTraderCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            dayTraderCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            dayTraderCell.topAnchor.constraint(equalTo: scalperCell.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            swingTraderCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            swingTraderCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            swingTraderCell.topAnchor.constraint(equalTo: dayTraderCell.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            positionTraderCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            positionTraderCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            positionTraderCell.topAnchor.constraint(equalTo: swingTraderCell.bottomAnchor, constant: 12.scale)
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
private extension OnbTradingStyleView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 32.scale))
            .lineHeight(38.4.scale)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.TradingStyle.Title".localized.attributed(with: attrs)
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
