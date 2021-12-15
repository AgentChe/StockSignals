//
//  PaygateTableTradersCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 14.12.2021.
//

import UIKit

final class PaygateTableTradersCell: UITableViewCell {
    lazy var titleLabel = makeTitleLabel()
    lazy var reviewsView = makeReviewsView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
        animateScrollReviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension PaygateTableTradersCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    func animateScrollReviews() {
        let no = reviewsView.contentOffset.x + 1
        
        UIView.animate(withDuration: 0.001, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
            self?.reviewsView.contentOffset = CGPoint(x: no, y: 0)
        }, completion: { [weak self] _ in
            self?.animateScrollReviews()
        })
    }
}

// MARK: Make constraints
private extension PaygateTableTradersCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            reviewsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            reviewsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            reviewsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.scale),
            reviewsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            reviewsView.heightAnchor.constraint(equalToConstant: 124.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension PaygateTableTradersCell {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 17.scale))
            .lineHeight(20.4.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Paygate.TradersLoveStocksSignals".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeReviewsView() -> PaygateReviewsView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 12.scale
        
        let view = PaygateReviewsView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.isScrollEnabled = false
        view.showsHorizontalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 16.scale, bottom: 0, right: 16.scale)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
