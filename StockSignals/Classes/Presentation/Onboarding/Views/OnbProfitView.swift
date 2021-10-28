//
//  OnbProfitView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 28.10.2021.
//

import UIKit

final class OnbProfitView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var profitTitleLabel = makeProfitTitleLabel()
    lazy var profitView = makeProfitView()
    lazy var rateView = makeRateView()
    lazy var slider = makeSlider()
    lazy var button = makeButton()
    
    private lazy var sliderValueLabel = makeSliderValueLabel()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        initialize()
        movedSlider()
    }
}

// MARK: Private
private extension OnbProfitView {
    func initialize() {
        backgroundColor = UIColor.clear
    }
    
    @objc
    func movedSlider() {
        slider.value = round(slider.value)
        
        let value = Int(slider.value)
        
        guard value <= 7 else {
            return
        }
        
        updateSliderValue(with: value)
        updateProfit(with: value)
        updateRate(with: value)
    }
    
    func updateSliderValue(with value: Int) {
        switch value {
        case 1, 2, 3, 4, 5:
            sliderValueLabel.text = String(format: "1:%i", value)
        case 6:
            sliderValueLabel.text = "1:10"
        case 7:
            sliderValueLabel.text = "1:20"
        default:
            break
        }
        
        sliderValueLabel.sizeToFit()

        let trackRect = slider.trackRect(forBounds: slider.frame)
        let thumbRect = slider.thumbRect(forBounds: slider.bounds, trackRect: trackRect, value: roundf(slider.value))
        sliderValueLabel.center = CGPoint(x: thumbRect.midX, y: slider.frame.minY - sliderValueLabel.frame.height)
    }
    
    func updateProfit(with value: Int) {
        let transformValue = transform(sliderValue: value)
        profitView.profit = transformValue
    }
    
    func updateRate(with value: Int) {
        let transformValue = transform(sliderValue: value)
        rateView.setup(value: transformValue)
    }
    
    func transform(sliderValue: Int) -> Int {
        switch sliderValue {
        case 1, 2, 3, 4, 5:
            return sliderValue
        case 6:
            return 10
        case 7:
            return 20
        default:
            return 20
        }
    }
}

// MARK: Make constraints
private extension OnbProfitView {
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
            rateView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rateView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rateView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 33.scale : 16.scale),
            rateView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 161.scale : 131.scale)
        ])
        
        NSLayoutConstraint.activate([
            profitTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            profitTitleLabel.topAnchor.constraint(equalTo: rateView.bottomAnchor, constant: 31.scale)
        ])
        
        NSLayoutConstraint.activate([
            profitView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            profitView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            profitView.heightAnchor.constraint(equalToConstant: 26.scale),
            profitView.topAnchor.constraint(equalTo: profitTitleLabel.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            slider.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -26.scale)
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
private extension OnbProfitView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 32.scale))
            .lineHeight(38.4.scale)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Profit.Title".localized.attributed(with: attrs)
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
        view.attributedText = "Onboarding.Profit.SubTitle".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeProfitTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 24.scale))
            .lineHeight(28.8.scale)
        
        let view = UILabel()
        view.attributedText = "Onboarding.Profit.Profit".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeProfitView() -> ProfitView {
        let view = ProfitView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeRateView() -> RateView {
        let view = RateView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSliderValueLabel() -> UILabel {
        let view = UILabel()
        view.textColor = UIColor.white
        view.font = Fonts.SFProDisplay.bold(size: 19.scale)
        addSubview(view)
        return view
    }
    
    func makeSlider() -> UISlider {
        let view = UISlider()
        view.layer.cornerRadius = 4.scale
        view.minimumValue = 1
        view.maximumValue = 7
        view.setThumbImage(UIImage(named: "Onboarding.Profit.Thumb"), for: .normal)
        view.minimumTrackTintColor = UIColor.white
        view.maximumTrackTintColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        view.addTarget(self, action: #selector(movedSlider), for: .valueChanged)
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
