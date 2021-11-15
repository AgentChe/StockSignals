//
//  DetailsFilterView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.11.2021.
//

import UIKit

final class DetailsFilterView: UIView {
    lazy var filter = DetailsFilter.overview {
        didSet {
            update()
        }
    }
    
    lazy var overviewButton = makeButton(title: "Details.Overview".localized)
    lazy var summaryButton = makeButton(title: "Details.Summary".localized)
    lazy var aboutCompanyButton = makeButton(title: "Details.AboutCompany".localized)
    
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
private extension DetailsFilterView {
    func update() {
        let color1 = UIColor(integralRed: 62, green: 89, blue: 223)
        let color2 = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        
        overviewButton.backgroundColor = filter == .overview ? color1 : color2
        summaryButton.backgroundColor = filter == .summary ? color1 : color2
        aboutCompanyButton.backgroundColor = filter == .aboutCompany ? color1 : color2
    }
}

// MARK: Make constraints
private extension DetailsFilterView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            overviewButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            overviewButton.widthAnchor.constraint(equalToConstant: 87.scale),
            overviewButton.heightAnchor.constraint(equalToConstant: 34.scale),
            overviewButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            summaryButton.leadingAnchor.constraint(equalTo: overviewButton.trailingAnchor, constant: 8.scale),
            summaryButton.widthAnchor.constraint(equalToConstant: 88.scale),
            summaryButton.heightAnchor.constraint(equalToConstant: 34.scale),
            summaryButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            aboutCompanyButton.leadingAnchor.constraint(equalTo: summaryButton.trailingAnchor, constant: 8.scale),
            aboutCompanyButton.widthAnchor.constraint(equalToConstant: 130.scale),
            aboutCompanyButton.heightAnchor.constraint(equalToConstant: 34.scale),
            aboutCompanyButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension DetailsFilterView {
    func makeButton(title: String) -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 15.scale))
        
        let view = UIButton()
        view.setAttributedTitle(title.attributed(with: attrs), for: .normal)
        view.layer.cornerRadius = 10.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
