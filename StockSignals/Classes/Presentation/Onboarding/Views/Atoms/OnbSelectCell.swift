//
//  OnbSelectCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 27.10.2021.
//

import UIKit

final class OnbSelectCell: GradientButton {
    var isSelect: Bool = false {
        didSet {
            updateColors()
        }
    }
    
    var title: String? {
        didSet {
            let attrs = TextAttributes()
                .textColor(UIColor.white)
                .font(Fonts.SFProDisplay.semiBold(size: 19.scale))
                .lineHeight(22.8.scale)
            label.attributedText = title?.attributed(with: attrs)
        }
    }
    
    lazy var label = makeLabel()
    
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
private extension OnbSelectCell {
    func initialize() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    }
    
    func updateColors() {
        let backgroundSelectedColors = [
            UIColor(integralRed: 112, green: 226, blue: 248, alpha: 0.6).cgColor,
            UIColor.clear.cgColor,
            UIColor(integralRed: 112, green: 226, blue: 248, alpha: 0.6).cgColor
        ]
        
        let backgroundDeselectedColors = [
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.clear.cgColor
        ]
        
        gradientLayer.colors = isSelect ? backgroundSelectedColors : backgroundDeselectedColors
        
        let borderSelectedColor = UIColor(integralRed: 112, green: 226, blue: 248).cgColor
        let borderDeselectedColor = UIColor(integralRed: 42, green: 46, blue: 57).cgColor
        
        layer.borderColor = isSelect ? borderSelectedColor : borderDeselectedColor
    }
}

// MARK: Make constraints
private extension OnbSelectCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 24.scale),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OnbSelectCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
