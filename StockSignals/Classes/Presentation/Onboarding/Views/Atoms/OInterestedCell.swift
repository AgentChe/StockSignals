//
//  OInterestedCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 27.10.2021.
//

import UIKit

final class OInterestedCell: UIButton {
    var isSelect: Bool = false {
        didSet {
            updateColors()
        }
    }
    
    var image: UIImage? {
        didSet {
            iconView.image = image
        }
    }
    
    var title: String? {
        didSet {
            let attrs = TextAttributes()
                .textColor(UIColor.white)
                .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
                .lineHeight(20.4.scale)
                .textAlignment(.center)
            label.attributedText = title?.attributed(with: attrs)
        }
    }
    
    lazy var selectedView = makeSelectedView()
    lazy var iconView = makeImageView()
    lazy var label = makeLabel()
    
    private let w: CGFloat
    private let h: CGFloat
    private let b: CGFloat
    
    init(w: CGFloat, h: CGFloat, b: CGFloat) {
        self.w = w
        self.h = h
        self.b = b
        
        super.init(frame: .zero)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OInterestedCell {
    func updateColors() {
        let backgroundSelectedColors = [
            UIColor(integralRed: 112, green: 226, blue: 248, alpha: 0.6).cgColor,
            UIColor.clear.cgColor,
            UIColor(integralRed: 112, green: 226, blue: 248, alpha: 0.6).cgColor
        ]

        let backgroundDeselectedColors = [
            UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7).cgColor,
            UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7).cgColor,
            UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7).cgColor
        ]

        selectedView.gradientLayer.colors = isSelect ? backgroundSelectedColors : backgroundDeselectedColors

        let borderSelectedColor = UIColor(integralRed: 112, green: 226, blue: 248).cgColor
        let borderDeselectedColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7).cgColor

        selectedView.layer.borderColor = isSelect ? borderSelectedColor : borderDeselectedColor
    }
}

// MARK: Make constraints
private extension OInterestedCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            selectedView.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectedView.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectedView.topAnchor.constraint(equalTo: topAnchor, constant: 7.scale),
            selectedView.heightAnchor.constraint(equalToConstant: 103.scale)
        ])
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: w),
            iconView.heightAnchor.constraint(equalToConstant: h),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.bottomAnchor.constraint(equalTo: selectedView.bottomAnchor, constant: b)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            label.topAnchor.constraint(equalTo: selectedView.bottomAnchor, constant: 12.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OInterestedCell {
    func makeSelectedView() -> GradientView {
        let view = GradientView()
        view.gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        view.gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = 16.scale
        view.layer.borderWidth = 1.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
