//
//  PaygateView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.12.2021.
//

import UIKit

final class PaygateView: UIView {
    lazy var tableView = makeTableView()
    lazy var closeButton = makeCloseButton()
    lazy var bottomContainer = makeBottomContainer()
    lazy var securedIconView = makeSecuredIconView()
    lazy var securedLabel = makeSecuredLabel()
    lazy var purchaseButton = makePurchaseButton()
    lazy var restoreButton = makeLinkButton(title: "Paygate.Restore".localized)
    lazy var termsButton = makeLinkButton(title: "Paygate.Terms".localized)
    lazy var privacyButton = makeLinkButton(title: "Paygate.Privacy".localized)
    
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
private extension PaygateView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
    }
}

// MARK: Make constraints
private extension PaygateView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomContainer.topAnchor, constant: -1.scale)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 36.scale),
            closeButton.heightAnchor.constraint(equalToConstant: 36.scale),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 68.scale),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale)
        ])
        
        NSLayoutConstraint.activate([
            bottomContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomContainer.heightAnchor.constraint(equalToConstant: 355.scale)
        ])
        
        NSLayoutConstraint.activate([
            securedIconView.widthAnchor.constraint(equalToConstant: 17.scale),
            securedIconView.heightAnchor.constraint(equalToConstant: 17.scale),
            securedIconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 68.scale),
            securedIconView.centerYAnchor.constraint(equalTo: securedLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            securedLabel.leadingAnchor.constraint(equalTo: securedIconView.trailingAnchor, constant: 5.scale),
            securedLabel.bottomAnchor.constraint(equalTo: purchaseButton.topAnchor, constant: -8.scale)
        ])
        
        NSLayoutConstraint.activate([
            purchaseButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            purchaseButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            purchaseButton.heightAnchor.constraint(equalToConstant: 60.scale),
            purchaseButton.bottomAnchor.constraint(equalTo: bottomContainer.bottomAnchor, constant: -76.scale)
        ])
        
        NSLayoutConstraint.activate([
            restoreButton.heightAnchor.constraint(equalToConstant: 17.scale),
            restoreButton.trailingAnchor.constraint(equalTo: termsButton.leadingAnchor, constant: -41.scale),
            restoreButton.centerYAnchor.constraint(equalTo: termsButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            termsButton.heightAnchor.constraint(equalToConstant: 17.scale),
            termsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            termsButton.bottomAnchor.constraint(equalTo: bottomContainer.bottomAnchor, constant: -35.scale)
        ])
        
        NSLayoutConstraint.activate([
            privacyButton.heightAnchor.constraint(equalToConstant: 17.scale),
            privacyButton.leadingAnchor.constraint(equalTo: termsButton.trailingAnchor, constant: 41.scale),
            privacyButton.centerYAnchor.constraint(equalTo: termsButton.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PaygateView {
    func makeTableView() -> PaygateTableView {
        let view = PaygateTableView()
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 35.scale, right: 0)
        view.backgroundColor = UIColor.clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCloseButton() -> UIButton {
        let view = UIButton()
        view.setImage(UIImage(named: "Paygate.Close"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeBottomContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 16.scale
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSecuredIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Paygate.Secured")
        view.translatesAutoresizingMaskIntoConstraints = false
        bottomContainer.addSubview(view)
        return view
    }
    
    func makeSecuredLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 252, green: 252, blue: 252))
            .font(Fonts.SFProDisplay.regular(size: 14.scale))
            .lineHeight(16.71.scale)
        
        let view = UILabel()
        view.attributedText = "Paygate.Secured".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        bottomContainer.addSubview(view)
        return view
    }
    
    func makePurchaseButton() -> PaygatePurchaseButton {
        let view = PaygatePurchaseButton()
        view.layer.cornerRadius = 16.scale
        view.backgroundColor = UIColor(integralRed: 62, green: 89, blue: 223)
        view.translatesAutoresizingMaskIntoConstraints = false
        bottomContainer.addSubview(view)
        return view
    }
    
    func makeLinkButton(title: String) -> TapAreaButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white.withAlphaComponent(0.4))
            .font(Fonts.SFProDisplay.semiBold(size: 14.scale))
        
        let view = TapAreaButton()
        view.dx = -20.scale
        view.dy = -20.scale
        view.setAttributedTitle(title.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        bottomContainer.addSubview(view)
        return view
    }
}
