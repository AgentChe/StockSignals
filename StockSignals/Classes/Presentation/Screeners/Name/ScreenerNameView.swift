//
//  ScreenerNameView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 04.12.2021.
//

import UIKit

final class ScreenerNameView: UIView {
    lazy var tappedAreaView = makeTappedArea()
    lazy var container = makeContainer()
    lazy var separator = makeSeparator()
    lazy var titleLabel = makeTitleLabel()
    lazy var textField = makeTextField()
    lazy var clearButton = makeClearButton()
    lazy var createButton = makeCreateButton()
    
    lazy var containerBottomConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
        didChangeText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension ScreenerNameView {
    func update(keyboardFrame: CGRect) {
        containerBottomConstraint.isActive = false
        
        containerBottomConstraint = container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -keyboardFrame.height)
        
        containerBottomConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.layoutIfNeeded()
        })
    }
}

// MARK: Private
private extension ScreenerNameView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36, alpha: 0.7)
    }
    
    @objc
    func didChangeText() {
        let text = textField.text ?? ""
        let isEmpty = text.isEmpty
        
        createButton.isEnabled = !isEmpty
        createButton.alpha = isEmpty ? 0.5 : 1
    }
    
    @objc
    func didClearTapped() {
        textField.text = nil
        didChangeText()
    }
}

// MARK: Make constraints
private extension ScreenerNameView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            tappedAreaView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tappedAreaView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tappedAreaView.topAnchor.constraint(equalTo: topAnchor),
            tappedAreaView.bottomAnchor.constraint(equalTo: container.topAnchor)
        ])
        
        containerBottomConstraint = container.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.heightAnchor.constraint(equalToConstant: 241.scale),
            containerBottomConstraint,
        ])
        
        NSLayoutConstraint.activate([
            separator.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            separator.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.scale),
            separator.heightAnchor.constraint(equalToConstant: 4.scale),
            separator.widthAnchor.constraint(equalToConstant: 50.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.scale),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 36.scale)
        ])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.scale),
            textField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -54.scale),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30.scale)
        ])
        
        NSLayoutConstraint.activate([
            clearButton.widthAnchor.constraint(equalToConstant: 24.scale),
            clearButton.heightAnchor.constraint(equalToConstant: 24.scale),
            clearButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24.scale),
            clearButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            createButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            createButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            createButton.heightAnchor.constraint(equalToConstant: 60.scale),
            createButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension ScreenerNameView {
    func makeTappedArea() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57)
        view.layer.cornerRadius = 16.scale
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        view.layer.cornerRadius = 2.5.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 234, green: 232, blue: 241))
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
            .lineHeight(22.8.scale)
        
        let view = UILabel()
        view.attributedText = "CreateScreener.Name.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeTextField() -> UITextField {
        let view = UITextField()
        view.autocorrectionType = .no
        view.backgroundColor = UIColor.clear
        view.font = Fonts.SFProDisplay.regular(size: 18.scale)
        view.textColor = UIColor(integralRed: 234, green: 232, blue: 241)
        view.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeClearButton() -> UIButton {
        let view = UIButton()
        view.setImage(UIImage(named: "WatchList.Close1"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(didClearTapped), for: .touchUpInside)
        container.addSubview(view)
        return view
    }
    
    func makeCreateButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
        
        let view = UIButton()
        view.layer.cornerRadius = 16.scale
        view.backgroundColor = UIColor(integralRed: 62, green: 89, blue: 223)
        view.setAttributedTitle("CreateScreener.Confirm".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
