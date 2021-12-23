//
//  OnbInterestedView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 27.10.2021.
//

import UIKit

final class OnbInterestedView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var shortTermCell = makeShortTermCell()
    lazy var longTermCell = makeLongTermCell()
    lazy var gainCell = makeGainCell()
    lazy var grossCell = makeCrossCell()
    lazy var button = makeButton()
    
    override init(step: OnboardingView.Step, scope: OnboardingScope) {
        super.init(step: step, scope: scope)
        
        makeConstraints()
        initialize()
        changeEnabled()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OnbInterestedView {
    func initialize() {
        backgroundColor = UIColor.clear
    }
    
    @objc
    func nextTappedAction() {
        let cells = [
            self.shortTermCell,
            self.longTermCell,
            self.gainCell,
            self.grossCell
        ]
        
        guard
            let tag = cells.first(where: { $0.isSelect })?.tag,
            let code = self.code(for: tag)
        else {
            return
        }
        
        scope.interested = code
        
        onNext()
    }
    
    func code(for tag: Int) -> String? {
        switch tag {
        case 1:
            return "short-term trading"
        case 2:
            return "long-term investments"
        case 3:
            return "gain experience"
        case 4:
            return "cross trades"
        default:
            return nil
        }
    }
    
    @objc
    func tapped(sender: Any) {
        guard let cell = sender as? OInterestedCell else {
            return
        }
        
        [
            shortTermCell,
            longTermCell,
            gainCell,
            grossCell
        ].forEach { $0.isSelect = false }

        cell.isSelect = true

        changeEnabled()
    }
    
    func changeEnabled() {
        let hasSelected = [
            shortTermCell,
            longTermCell,
            gainCell,
            grossCell
        ].contains(where: { $0.isSelect })
        
        button.isEnabled = hasSelected
        button.alpha = hasSelected ? 1 : 0.6
    }
}

// MARK: Make constraints
private extension OnbInterestedView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 145.scale : 90.scale)
        ])
        
        NSLayoutConstraint.activate([
            shortTermCell.widthAnchor.constraint(equalToConstant: 156.scale),
            shortTermCell.heightAnchor.constraint(equalToConstant: 163.scale),
            shortTermCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            shortTermCell.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35.scale)
        ])
        
        NSLayoutConstraint.activate([
            longTermCell.widthAnchor.constraint(equalToConstant: 156.scale),
            longTermCell.heightAnchor.constraint(equalToConstant: 163.scale),
            longTermCell.leadingAnchor.constraint(equalTo: shortTermCell.trailingAnchor, constant: 15.scale),
            longTermCell.topAnchor.constraint(equalTo: shortTermCell.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            gainCell.widthAnchor.constraint(equalToConstant: 156.scale),
            gainCell.heightAnchor.constraint(equalToConstant: 163.scale),
            gainCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            gainCell.topAnchor.constraint(equalTo: shortTermCell.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            grossCell.widthAnchor.constraint(equalToConstant: 156.scale),
            grossCell.heightAnchor.constraint(equalToConstant: 163.scale),
            grossCell.leadingAnchor.constraint(equalTo: gainCell.trailingAnchor, constant: 15.scale),
            grossCell.topAnchor.constraint(equalTo: gainCell.topAnchor)
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
private extension OnbInterestedView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 32.scale))
            .lineHeight(38.4.scale)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Interested.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeShortTermCell() -> OInterestedCell {
        let view = OInterestedCell(w: 99.scale, h: 110.scale, b: -16.scale)
        view.tag = 1
        view.isSelect = false
        view.title = "Onboarding.Interested.ShortTerm".localized
        view.image = UIImage(named: "Onboarding.Interested.ShortTerm")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(tapped(sender:)), for: .touchUpInside)
        addSubview(view)
        return view
    }
    
    func makeLongTermCell() -> OInterestedCell {
        let view = OInterestedCell(w: 156.scale, h: 142.scale, b: 6.scale)
        view.tag = 2
        view.isSelect = false
        view.title = "Onboarding.Interested.LongTerm".localized
        view.image = UIImage(named: "Onboarding.Interested.LongTerm")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(tapped(sender:)), for: .touchUpInside)
        addSubview(view)
        return view
    }
    
    func makeGainCell() -> OInterestedCell {
        let view = OInterestedCell(w: 99.scale, h: 94.scale, b: -16.scale)
        view.tag = 3
        view.isSelect = false
        view.title = "Onboarding.Interested.Gain".localized
        view.image = UIImage(named: "Onboarding.Interested.Gain")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(tapped(sender:)), for: .touchUpInside)
        addSubview(view)
        return view
    }
    
    func makeCrossCell() -> OInterestedCell {
        let view = OInterestedCell(w: 111.scale, h: 101.scale, b: -9.scale)
        view.tag = 4
        view.isSelect = false
        view.title = "Onboarding.Interested.Cross".localized
        view.image = UIImage(named: "Onboarding.Interested.Cross")
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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(nextTappedAction), for: .touchUpInside)
        addSubview(view)
        return view
    }
}
