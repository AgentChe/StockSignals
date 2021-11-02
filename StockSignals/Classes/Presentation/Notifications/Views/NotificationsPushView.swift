//
//  NotificationsPushView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.11.2021.
//

import UIKit

final class NotificationsPushView: UIView {
    lazy var textLabel = makeLabel()
    lazy var button = makeButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Make constraints
private extension NotificationsPushView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -132.scale),
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.scale),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 100.scale),
            button.heightAnchor.constraint(equalToConstant: 41.scale),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension NotificationsPushView {
    func makeLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.regular(size: 17.scale))
            .lineHeight(20.4.scale)
        
        let view = UILabel()
        view.attributedText = "Notifications.Push.Text".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 17.scale))
        
        let view = UIButton()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        view.layer.cornerRadius = 10.scale
        view.setAttributedTitle("Notifications.Push.Button".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
