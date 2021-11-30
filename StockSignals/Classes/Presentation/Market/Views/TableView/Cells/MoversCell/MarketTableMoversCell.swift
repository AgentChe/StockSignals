//
//  MarketTableMoversCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.11.2021.
//

import UIKit

final class MarketTableMoversCell: UITableViewCell {
    lazy var titleLabel = makeTitleLabel()
    lazy var collectionView = makeCollectionView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension MarketTableMoversCell {
    func setup(elements: [MarketMoversCollectionElement]) {
        collectionView.setup(elements: elements)
    }
}

// MARK: Private
private extension MarketTableMoversCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension MarketTableMoversCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 192.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension MarketTableMoversCell {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
            .lineHeight(26.6.scale)
        
        let view = UILabel()
        view.attributedText = "Market.Movers".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCollectionView() -> MarketMoversCollectionView {
        let layout = MarketMoversCollectionLayout()
        
        let view = MarketMoversCollectionView(frame: .zero, collectionViewLayout: layout)
        view.layer.cornerRadius = 20.scale
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
