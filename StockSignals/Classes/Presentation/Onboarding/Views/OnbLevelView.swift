//
//  OnbLevelView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 27.10.2021.
//

import UIKit
import RxSwift

final class OnbLevelView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var column1View = makeColumnView()
    lazy var column2View = makeColumnView()
    lazy var column3View = makeColumnView()
    lazy var column4View = makeColumnView()
    lazy var slider = makeSlider()
    lazy var descrTitleLabel = makeDescrLabel()
    lazy var descrValueLabel = makeDescrLabel()
    lazy var button = makeButton()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var contentManager = ContentManagerCore()
    
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
private extension OnbLevelView {
    func initialize() {
        backgroundColor = UIColor.clear
        
        button.rx.tap
            .flatMapLatest { [weak self] _ -> Single<Bool> in
                guard let self = self else {
                    return .never()
                }
                
                let level = Int(self.slider.value) - 1
                
                return self.contentManager.set(level: level)
                    .map { true }
                    .catchAndReturn(false)
            }
            .subscribe(onNext: { [weak self] success in
                guard success else {
                    Toast.notify(with: "Error".localized, style: .danger)
                    return
                }
                
                self?.onNext()
            })
            .disposed(by: disposeBag)
    }
    
    @objc
    func movedSlider() {
        slider.value = round(slider.value)
        
        let value = Int(slider.value)
        
        updateColums(value: value)
        updateDescr(value: value)
    }
    
    func updateColums(value: Int) {
        let selected = [
            UIColor(integralRed: 112, green: 226, blue: 248).cgColor,
            UIColor(integralRed: 62, green: 89, blue: 223).cgColor
        ]
        
        let deselected = [
            UIColor(integralRed: 42, green: 46, blue: 57).cgColor,
            UIColor(integralRed: 42, green: 46, blue: 57).cgColor
        ]
        
        column1View.gradientLayer.colors = value >= 1 ? selected : deselected
        column2View.gradientLayer.colors = value >= 2 ? selected : deselected
        column3View.gradientLayer.colors = value >= 3 ? selected : deselected
        column4View.gradientLayer.colors = value >= 4 ? selected : deselected
    }
    
    func updateDescr(value: Int) {
        let title: String
        let descr: String
        
        switch value {
        case 1:
            title = "Onboarding.Level.Novice".localized
            descr = "Onboarding.Level.Novice.Descr".localized
        case 2:
            title = "Onboarding.Level.Amateur".localized
            descr = "Onboarding.Level.Amateur.Descr".localized
        case 3:
            title = "Onboarding.Level.Experienced".localized
            descr = "Onboarding.Level.Experienced.Descr".localized
        case 4:
            title = "Onboarding.Level.Expert".localized
            descr = "Onboarding.Level.Expert.Descr".localized
        default:
            title = ""
            descr = ""
        }
        
        let titleAttrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 19.scale))
            .lineHeight(22.8.scale)
            .textAlignment(.center)
        descrTitleLabel.attributedText = title.attributed(with: titleAttrs)
        
        let descrAttrs = TextAttributes()
            .textColor(UIColor.white.withAlphaComponent(0.4))
            .font(Fonts.SFProDisplay.regular(size: 17.scale))
            .lineHeight(22.8.scale)
            .textAlignment(.center)
        descrValueLabel.attributedText = descr.attributed(with: descrAttrs)
    }
}

// MARK: Make constraints
private extension OnbLevelView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 145.scale : 60.scale)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            column1View.widthAnchor.constraint(equalToConstant: 76.scale),
            column1View.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 85.scale : 65.scale),
            column1View.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23.scale),
            column1View.bottomAnchor.constraint(equalTo: column4View.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            column2View.widthAnchor.constraint(equalToConstant: 76.scale),
            column2View.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 120.scale : 100.scale),
            column2View.leadingAnchor.constraint(equalTo: column1View.trailingAnchor, constant: 8.scale),
            column2View.bottomAnchor.constraint(equalTo: column4View.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            column3View.widthAnchor.constraint(equalToConstant: 76.scale),
            column3View.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 171.scale : 151.scale),
            column3View.leadingAnchor.constraint(equalTo: column2View.trailingAnchor, constant: 8.scale),
            column3View.bottomAnchor.constraint(equalTo: column4View.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            column4View.widthAnchor.constraint(equalToConstant: 76.scale),
            column4View.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 259.scale : 239.scale),
            column4View.leadingAnchor.constraint(equalTo: column3View.trailingAnchor, constant: 8.scale),
            column4View.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23.scale),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23.scale),
            slider.topAnchor.constraint(equalTo: column4View.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descrTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23.scale),
            descrTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23.scale),
            descrTitleLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 23.scale)
        ])
        
        NSLayoutConstraint.activate([
            descrValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23.scale),
            descrValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23.scale),
            descrValueLabel.topAnchor.constraint(equalTo: descrTitleLabel.bottomAnchor, constant: 8.scale)
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
private extension OnbLevelView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 32.scale))
            .lineHeight(38.4.scale)
        
        let view = UILabel()
        view.attributedText = "Onboarding.Level.Title".localized.attributed(with: attrs)
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
        view.attributedText = "Onboarding.Level.SubTitle".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeColumnView() -> GradientView {
        let view = GradientView()
        view.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        view.gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.gradientLayer.colors = [
            UIColor(integralRed: 42, green: 46, blue: 57).cgColor,
            UIColor(integralRed: 42, green: 46, blue: 57).cgColor
        ]
        view.layer.cornerRadius = 16.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSlider() -> UISlider {
        let view = UISlider()
        view.minimumValue = 1
        view.maximumValue = 4
        view.minimumTrackTintColor = UIColor(integralRed: 112, green: 226, blue: 248)
        view.maximumTrackTintColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        view.setThumbImage(UIImage(named: "Onboarding.Level.Thumb"), for: .normal)
        view.addTarget(self, action: #selector(movedSlider), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeDescrLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
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
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
