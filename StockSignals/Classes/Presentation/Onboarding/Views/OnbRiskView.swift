//
//  OnbRiskView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 28.10.2021.
//

import UIKit

final class OnbRiskView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var container = makeContainer()
    lazy var iconView = makeIconView()
    lazy var slider = makeSlider()
    lazy var gainLabel = makeGainLabel()
    lazy var button = makeButton()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
        initialize()
        movedSlider()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OnbRiskView {
    func initialize() {
        backgroundColor = UIColor.clear
    }
    
    @objc
    func movedSlider() {
        slider.value = round(slider.value)
        
        let value = Int(slider.value)
        
        update(value: value)
    }
    
    func update(value: Int) {
        let isLow = value <= 2
        
        let gainAttrs = TextAttributes()
            .font(Fonts.SFProDisplay.semiBold(size: 15.scale))
            .lineHeight(18.scale)
            .textColor(UIColor.white)
            .textAlignment(.center)
        
        let valueAttrs = TextAttributes()
            .font(Fonts.SFProDisplay.semiBold(size: 15.scale))
            .lineHeight(18.scale)
            .textColor(isLow ? UIColor(integralRed: 247, green: 118, blue: 101) : UIColor(integralRed: 129, green: 232, blue: 129))
            .textAlignment(.center)
        
        let valueString = isLow ? "Onboarding.Risk.Low" : "Onboarding.Risk.High"
        
        let string = NSMutableAttributedString()
        string.append("Onboarding.Risk.MaxGain".localized.attributed(with: gainAttrs))
        string.append(valueString.localized.attributed(with: valueAttrs))
        
        gainLabel.attributedText = string
        
        iconView.image = UIImage(named: "Onboarding.Risk.\(value)")
    }
}

// MARK: Make constraints
private extension OnbRiskView {
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
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            container.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 24.scale),
            container.heightAnchor.constraint(equalToConstant: 103.scale)
        ])
        
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.scale),
            iconView.widthAnchor.constraint(equalToConstant: 46.scale),
            iconView.heightAnchor.constraint(equalToConstant: 46.scale)
        ])
        
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 74.scale),
            slider.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            slider.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            slider.heightAnchor.constraint(equalToConstant: 32.scale)
        ])
        
        NSLayoutConstraint.activate([
            gainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            gainLabel.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 12.scale)
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
private extension OnbRiskView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 32.scale))
            .lineHeight(38.4.scale)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Risk.Title".localized.attributed(with: attrs)
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
        view.attributedText = "Onboarding.Risk.SubTitle".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 16.scale
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeSlider() -> UISlider {
        let view = UISlider()
        view.minimumValue = 1
        view.maximumValue = 4
        view.minimumTrackTintColor = UIColor(integralRed: 62, green: 89, blue: 223)
        view.maximumTrackTintColor = UIColor(integralRed: 24, green: 26, blue: 36)
        view.setThumbImage(UIImage(named: "Onboarding.Risk.Thumb"), for: .normal)
        view.addTarget(self, action: #selector(movedSlider), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeGainLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
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
