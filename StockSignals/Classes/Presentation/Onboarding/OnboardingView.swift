//
//  OnboardingView.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 17.01.2021.
//

import UIKit

final class OnboardingView: UIView {
    enum Step: Int {
        case level, assetsSignals, tradingStyle, interested, risk, industries, stocks
    }
    
    var didFinish: (() -> Void)?
    
    var step = Step.level {
        didSet {
            scroll()
            headerUpdate()
        }
    }
    
    lazy var headerImageView = makeHeaderImageView()
    lazy var scrollView = makeScrollView()
    lazy var backButton = makeBackButton()
    lazy var skipButton = makeSkipButton()
    
    private weak var vc: UIViewController?
    
    private lazy var contentViews: [OSlideView] = {
        [
            OnbLevelView(step: .level),
            OnbAssetsSignalsView(step: .assetsSignals),
            OnbTradingStyleView(step: .tradingStyle),
            OnbInterestedView(step: .interested),
            OnbRiskView(step: .risk),
            OnbIndustriesView(step: .industries),
            OnbStocksView(step: .stocks)
        ]
    }()
    
    convenience init(vc: UIViewController?) {
        self.init(frame: .zero)
        
        self.vc = vc
        
        makeConstraints()
        initialize()
        headerUpdate()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension OnboardingView {
    func slideViewMoveToPrevious(from step: Step) {
        let previousRawValue = step.rawValue - 1
        
        guard let previousStep = Step(rawValue: previousRawValue) else {
            return
        }
        
        self.step = previousStep
    }
}

// MARK: OSlideViewDelegate
extension OnboardingView: OSlideViewDelegate {
    func slideViewDidNext(from step: Step) {
        let nextRawValue = step.rawValue + 1

        guard let nextStep = Step(rawValue: nextRawValue) else {
            didFinish?()

            return
        }

        self.step = nextStep
    }
}

// MARK: Private
private extension OnboardingView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
        
        contentViews
            .enumerated()
            .forEach { [weak self] index, view in
                scrollView.addSubview(view)
                
                view.delegate = self
                
                view.frame.origin = CGPoint(x: UIScreen.main.bounds.width * CGFloat(index), y: 0)
                view.frame.size = CGSize(width: UIScreen.main.bounds.width,
                                         height: UIScreen.main.bounds.height)
            }
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(contentViews.count),
                                        height: UIScreen.main.bounds.height)
    }
    
    func scroll() {
        let index = step.rawValue
        
        guard contentViews.indices.contains(index) else {
            return
        }
        
        let view = contentViews[index]
        let frame = contentViews[index].frame
        
        scrollView.scrollRectToVisible(frame, animated: true)
        
        view.moveToThis()
    }
    
    func headerUpdate() {
        let hideBackButton: [Step] = [.level]
        let hideSkipButton: [Step] = []
        
        backButton.isHidden = hideBackButton.contains(step)
        skipButton.isHidden = hideSkipButton.contains(step)
    }
    
    @objc
    func skipTapped() {
        slideViewDidNext(from: step)
    }
}

// MARK: Make constraints
private extension OnboardingView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20.scale),
            headerImageView.heightAnchor.constraint(equalToConstant: 258.scale)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 24.scale),
            backButton.heightAnchor.constraint(equalToConstant: 24.scale),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            backButton.centerYAnchor.constraint(equalTo: skipButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            skipButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            skipButton.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 83.scale : 43.scale),
            skipButton.heightAnchor.constraint(equalToConstant: 20.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OnboardingView {
    func makeHeaderImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "Onboarding.Header")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeScrollView() -> UIScrollView {
        let view = UIScrollView()
        view.backgroundColor = UIColor.clear
        view.isScrollEnabled = false
        view.isPagingEnabled = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeBackButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.setImage(UIImage(named: "Onboarding.Back"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSkipButton() -> TapAreaButton {
        let attrs = TextAttributes()
            .font(Fonts.SFProDisplay.regular(size: 17.scale))
            .textColor(UIColor.white.withAlphaComponent(0.4))
        
        let view = TapAreaButton()
        view.setAttributedTitle("Onboarding.Skip".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
