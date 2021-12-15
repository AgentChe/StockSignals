//
//  PaygateReviewStarsView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 14.12.2021.
//

import UIKit

final class PaygateReviewStarsView: UIView {
    lazy var stars = 0 {
        didSet {
            update()
        }
    }
    
    lazy var icon1View = makeIconView()
    lazy var icon2View = makeIconView()
    lazy var icon3View = makeIconView()
    lazy var icon4View = makeIconView()
    lazy var icon5View = makeIconView()
    
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
private extension PaygateReviewStarsView {
    func update() {
        icon1View.isHidden = stars < 1
        icon2View.isHidden = stars < 2
        icon3View.isHidden = stars < 3
        icon4View.isHidden = stars < 4
        icon5View.isHidden = stars < 5
    }
}

// MARK: Make constraints
private extension PaygateReviewStarsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            icon1View.widthAnchor.constraint(equalToConstant: 12.scale),
            icon1View.heightAnchor.constraint(equalToConstant: 12.scale),
            icon1View.leadingAnchor.constraint(equalTo: leadingAnchor),
            icon1View.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            icon2View.widthAnchor.constraint(equalToConstant: 12.scale),
            icon2View.heightAnchor.constraint(equalToConstant: 12.scale),
            icon2View.leadingAnchor.constraint(equalTo: icon1View.trailingAnchor, constant: 1.scale),
            icon2View.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            icon3View.widthAnchor.constraint(equalToConstant: 12.scale),
            icon3View.heightAnchor.constraint(equalToConstant: 12.scale),
            icon3View.leadingAnchor.constraint(equalTo: icon2View.trailingAnchor, constant: 1.scale),
            icon3View.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            icon4View.widthAnchor.constraint(equalToConstant: 12.scale),
            icon4View.heightAnchor.constraint(equalToConstant: 12.scale),
            icon4View.leadingAnchor.constraint(equalTo: icon3View.trailingAnchor, constant: 1.scale),
            icon4View.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            icon5View.widthAnchor.constraint(equalToConstant: 12.scale),
            icon5View.heightAnchor.constraint(equalToConstant: 12.scale),
            icon5View.leadingAnchor.constraint(equalTo: icon4View.trailingAnchor, constant: 1.scale),
            icon5View.trailingAnchor.constraint(equalTo: trailingAnchor),
            icon5View.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PaygateReviewStarsView {
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Paygate.Star")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
