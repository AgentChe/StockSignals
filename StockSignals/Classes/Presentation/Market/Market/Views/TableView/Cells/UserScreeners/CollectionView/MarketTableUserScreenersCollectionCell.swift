//
//  MarketTableUserScreenersCollectionCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 06.12.2021.
//

import UIKit

final class MarketTableUserScreenersCollectionCell: UICollectionViewCell {
    lazy var container = makeContainer()
    lazy var titleLabel = makeTitleLabel()
    lazy var userScreener1View = makeUserScreenerView()
    lazy var userScreener2View = makeUserScreenerView()
    lazy var userScreener3View = makeUserScreenerView()
    lazy var userScreener4View = makeUserScreenerView()
    
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
extension MarketTableUserScreenersCollectionCell {
    func setup(element: UserScreener) {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
            .lineHeight(26.6.scale)
        titleLabel.attributedText = element.name.attributed(with: attrs)
        
        let quotations = element.quotations
        
        userScreener1View.setup(element: get(array: quotations, index: 0))
        userScreener2View.setup(element: get(array: quotations, index: 1))
        userScreener3View.setup(element: get(array: quotations, index: 2))
        userScreener4View.setup(element: get(array: quotations, index: 3))
    }
}

// MARK: Private
private extension MarketTableUserScreenersCollectionCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
    }
    
    func get(array: [Quotation], index: Int) -> Quotation? {
        guard array.indices.contains(index) else {
            return nil
        }
        
        return array[index]
    }
}

// MARK: Make constraints
private extension MarketTableUserScreenersCollectionCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.scale),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.scale),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            userScreener1View.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            userScreener1View.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            userScreener1View.topAnchor.constraint(equalTo: container.topAnchor, constant: 75.scale),
            userScreener1View.heightAnchor.constraint(equalToConstant: 48.scale)
        ])
        
        NSLayoutConstraint.activate([
            userScreener2View.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            userScreener2View.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            userScreener2View.topAnchor.constraint(equalTo: userScreener1View.bottomAnchor, constant: 24.scale),
            userScreener2View.heightAnchor.constraint(equalToConstant: 48.scale)
        ])
        
        NSLayoutConstraint.activate([
            userScreener3View.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            userScreener3View.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            userScreener3View.topAnchor.constraint(equalTo: userScreener2View.bottomAnchor, constant: 24.scale),
            userScreener3View.heightAnchor.constraint(equalToConstant: 48.scale)
        ])
        
        NSLayoutConstraint.activate([
            userScreener4View.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            userScreener4View.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            userScreener4View.topAnchor.constraint(equalTo: userScreener3View.bottomAnchor, constant: 24.scale),
            userScreener4View.heightAnchor.constraint(equalToConstant: 48.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension MarketTableUserScreenersCollectionCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        view.layer.cornerRadius = 20.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeUserScreenerView() -> MarketTableUserScreenerView {
        let view = MarketTableUserScreenerView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
