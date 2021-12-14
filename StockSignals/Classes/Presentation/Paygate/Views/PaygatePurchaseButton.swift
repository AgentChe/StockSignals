//
//  PaygatePurchaseButton.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 10.12.2021.
//

import UIKit

final class PaygatePurchaseButton: UIButton {
    lazy var label = makeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension PaygatePurchaseButton {
    func setup(top: String, bottom: String?) {
        let string1 = top
            .attributed(with: TextAttributes()
                            .font(Fonts.SFProDisplay.bold(size: 19.scale))
                            .textColor(UIColor.white)
                            .lineHeight(22.8.scale)
                            .textAlignment(.center))
        let string2 = bottom?
            .attributed(with: TextAttributes()
                            .font(Fonts.SFProDisplay.regular(size: 15.scale))
                            .textColor(UIColor.white)
                            .lineHeight(18.scale)
                            .textAlignment(.center))
        
        let string = NSMutableAttributedString()
        string.append(string1)
        
        if let string2 = string2 {
            string.append(NSAttributedString(string: "\n"))
            string.append(string2)
        }
        
        label.attributedText = string
    }
}

// MARK: Make constraints
private extension PaygatePurchaseButton {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PaygatePurchaseButton {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
