//
//  OnbPreloaderView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 28.10.2021.
//

import UIKit
import Lottie

final class OnbPreloaderView: OSlideView {
    lazy var animationView = makeAnimationView()
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var infoLabel = makeLabel()
    
    private var timer: Timer?
    
    override init(step: OnboardingView.Step, scope: OnboardingScope) {
        super.init(step: step, scope: scope)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func moveToThis() {
        super.moveToThis()
        
        animationView.play()
        calculatePercent()
    }
}

// MARK: Private
private extension OnbPreloaderView {
    func initialize() {
        backgroundColor = UIColor.clear
    }
    
    func calculatePercent() {
        let duration = Double(4.5)
        var seconds = Double(0)
        
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
            .lineHeight(22.8.scale)
            .textAlignment(.center)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            seconds += 0.1
            
            var percent = Int(seconds / duration * 100)
            if percent > 100 {
                percent = 100
            }
            
            if percent <= 33 {
                self?.infoLabel.attributedText = "Onboarding.Preloader.Info1".localized.attributed(with: attrs)
            } else if percent <= 66 {
                self?.infoLabel.attributedText = "Onboarding.Preloader.Info2".localized.attributed(with: attrs)
            } else {
                self?.infoLabel.attributedText = "Onboarding.Preloader.Info3".localized.attributed(with: attrs)
            }
            
            if seconds >= duration {
                timer.invalidate()
                
                self?.finish()
            }
        }
    }
    
    func finish() {
        timer = nil
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [weak self] in
            self?.animationView.stop()
            self?.onNext()
        }
    }
}

// MARK: Make constraints
private extension OnbPreloaderView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 300.scale : 220.scale),
            animationView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 300.scale : 220.scale),
            animationView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 118.scale : 80.scale),
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            titleLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 36.scale)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            infoLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -60.scale : -40.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OnbPreloaderView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 32.scale))
            .lineHeight(38.4.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Preloader.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSubTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white.withAlphaComponent(0.4))
            .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
            .lineHeight(23.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Preloader.SubTitle".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeAnimationView() -> AnimationView {
        let view = AnimationView()
        view.animation = Animation.named("Onboarding.Preloader")
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
