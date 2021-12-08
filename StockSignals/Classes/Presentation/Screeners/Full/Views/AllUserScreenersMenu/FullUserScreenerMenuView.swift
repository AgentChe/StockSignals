//
//  FullUserScreenerMenuView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 08.12.2021.
//

import UIKit

final class FullUserScreenerMenuView: UIView {
    lazy var tappedArea = makeTappedArea()
    lazy var container = makeContainer()
    lazy var separator = makeSeparator()
    lazy var editButton = makeEditButton()
    lazy var deleteButton = makeDeleteButton()
    
    private lazy var containerBottomConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension FullUserScreenerMenuView {
    func show() {
        isHidden = false
        
        containerBottomConstraint.isActive = false
        containerBottomConstraint = container.bottomAnchor.constraint(equalTo: bottomAnchor)
        containerBottomConstraint.isActive = true
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.layoutIfNeeded()
        })
    }
    
    func hide(completion: (() -> Void)?) {
        isHidden = true
        
        containerBottomConstraint.isActive = false
        containerBottomConstraint = container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 200.scale)
        containerBottomConstraint.isActive = true
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.layoutIfNeeded()
        }, completion: { _ in
            completion?()
        })
    }
}

// MARK: Private
private extension FullUserScreenerMenuView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36, alpha: 0.7)
    }
}

// MARK: Make constraints
private extension FullUserScreenerMenuView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            tappedArea.leadingAnchor.constraint(equalTo: leadingAnchor),
            tappedArea.trailingAnchor.constraint(equalTo: trailingAnchor),
            tappedArea.topAnchor.constraint(equalTo: topAnchor),
            tappedArea.bottomAnchor.constraint(equalTo: container.topAnchor)
        ])
        
        containerBottomConstraint = container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 200.scale)
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerBottomConstraint,
            container.heightAnchor.constraint(equalToConstant: 200.scale)
        ])
        
        NSLayoutConstraint.activate([
            separator.centerXAnchor.constraint(equalTo: centerXAnchor),
            separator.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.scale),
            separator.widthAnchor.constraint(equalToConstant: 50.scale),
            separator.heightAnchor.constraint(equalToConstant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            editButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            editButton.heightAnchor.constraint(equalToConstant: 32.scale),
            editButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 52.scale)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 32.scale),
            deleteButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 108.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension FullUserScreenerMenuView {
    func makeTappedArea() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57)
        view.layer.cornerRadius = 12.scale
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        view.layer.cornerRadius = 2.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeEditButton() -> FullUserScreenerMenuButton {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 234, green: 232, blue: 241))
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
            .lineHeight(22.8.scale)
        
        let view = FullUserScreenerMenuButton()
        view.iconView.image = UIImage(named: "Screeners.Edit")
        view.label.attributedText = "AllUserScreeners.Edit".localized.attributed(with: attrs)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeDeleteButton() -> FullUserScreenerMenuButton {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 235, green: 96, blue: 42))
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
            .lineHeight(22.8.scale)
        
        let view = FullUserScreenerMenuButton()
        view.iconView.image = UIImage(named: "Screeners.Delete")
        view.label.attributedText = "AllUserScreeners.Delete".localized.attributed(with: attrs)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
