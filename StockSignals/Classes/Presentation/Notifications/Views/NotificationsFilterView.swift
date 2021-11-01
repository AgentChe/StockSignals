//
//  NotificationsFilterView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 01.11.2021.
//

import UIKit

final class NotificationsFilterView: UIView {
    lazy var type = NotificationType.stock {
        didSet {
            update()
        }
    }
    
    lazy var stockButton = makeButton(title: "Notifications.Stock".localized)
    lazy var optionButton = makeButton(title: "Notifications.Option".localized)
    lazy var cryptoButton = makeButton(title: "Notifications.Crypto".localized)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension NotificationsFilterView {
    func update() {
        stockButton.setTitleColor(type == .stock ? UIColor.white : UIColor.white.withAlphaComponent(0.4), for: .normal)
        optionButton.setTitleColor(type == .option ? UIColor.white : UIColor.white.withAlphaComponent(0.4), for: .normal)
        cryptoButton.setTitleColor(type == .crypto ? UIColor.white : UIColor.white.withAlphaComponent(0.4), for: .normal)
        
        stockButton.backgroundColor = type == .stock ? UIColor(integralRed: 62, green: 89, blue: 223) : UIColor.clear
        optionButton.backgroundColor = type == .option ? UIColor(integralRed: 62, green: 89, blue: 223) : UIColor.clear
        cryptoButton.backgroundColor = type == .crypto ? UIColor(integralRed: 62, green: 89, blue: 223) : UIColor.clear
    }
}

// MARK: Make constraints
private extension NotificationsFilterView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            stockButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4.scale),
            stockButton.topAnchor.constraint(equalTo: topAnchor, constant: 4.scale),
            stockButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4.scale),
            stockButton.widthAnchor.constraint(equalToConstant: 111.scale)
        ])
        
        NSLayoutConstraint.activate([
            optionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            optionButton.topAnchor.constraint(equalTo: topAnchor, constant: 4.scale),
            optionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4.scale),
            optionButton.widthAnchor.constraint(equalToConstant: 111.scale)
        ])
        
        NSLayoutConstraint.activate([
            cryptoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4.scale),
            cryptoButton.topAnchor.constraint(equalTo: topAnchor, constant: 4.scale),
            cryptoButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4.scale),
            cryptoButton.widthAnchor.constraint(equalToConstant: 111.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension NotificationsFilterView {
    func makeButton(title: String) -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
        
        let view = UIButton()
        view.layer.cornerRadius = 12.scale
        view.setAttributedTitle(title.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
