//
//  SplashView.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 17.01.2021.
//

import UIKit

protocol SplashViewDelegate: AnyObject {
    func splashViewDidSwipe()
}

final class SplashView: UIView {
    weak var delegate: SplashViewDelegate?
    
    lazy var imageView = makeImageView()
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var slider = makeSlider()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension SplashView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
    }
    
    @objc
    func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .moved:
                let max = Int(slider.value) == 10
                let image = UIImage(named: max ? "Splash.Thumb.End" : "Splash.Thumb.Start")
                slider.setThumbImage(image, for: .normal)
            case .ended:
                let value = Int(slider.value)
                
                if value < 10 {
                    slider.value = 1
                } else {
                    delegate?.splashViewDidSwipe()
                }
            default:
                break
            }
        }
    }
}

// MARK: Make constraints
private extension SplashView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 428.scale : 300.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.scale),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.scale),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.scale),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            slider.heightAnchor.constraint(equalToConstant: 60.scale),
            slider.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 31.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension SplashView {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "Splash.Image")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.black(size: 45.scale))
            .lineHeight(46.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Splash.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSubTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white.withAlphaComponent(0.4))
            .font(Fonts.SFProDisplay.semiBold(size: 20.scale))
            .lineHeight(28.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Splash.SubTitle".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSlider() -> UISlider {
        let view = UISlider()
        view.isHidden = true
        view.minimumValue = 1
        view.maximumValue = 10
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        view.layer.cornerRadius = 12.scale
        view.maximumTrackTintColor = UIColor.clear
        view.minimumTrackTintColor = UIColor.clear
        view.setThumbImage(UIImage(named: "Splash.Thumb.Start"), for: .normal)
        view.isContinuous = true
        view.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
