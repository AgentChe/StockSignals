//
//  MarketTableAllScreenersCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 30.11.2021.
//

import UIKit

final class MarketTableAllScreenersCell: UITableViewCell {
    weak var mainDelegate: MarketTableViewDelegate?
    
    lazy var titleLabel = makeTitleLabel()
    lazy var allLabel = makeAllLabel()
    lazy var arrowView = makeArrowView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
        addTapAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension MarketTableAllScreenersCell {
    func initialize() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    func addTapAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapped))
        contentView.isUserInteractionEnabled = true
        contentView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func didTapped() {
        mainDelegate?.marketTableDidSelectAllScreeners()
    }
}

// MARK: Make constraints
private extension MarketTableAllScreenersCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            allLabel.trailingAnchor.constraint(equalTo: arrowView.leadingAnchor, constant: -8.scale),
            allLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            arrowView.widthAnchor.constraint(equalToConstant: 34.scale),
            arrowView.heightAnchor.constraint(equalToConstant: 34.scale),
            arrowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            arrowView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension MarketTableAllScreenersCell {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
            .lineHeight(26.6.scale)
        
        let view = UILabel()
        view.attributedText = "Market.Screeners".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeAllLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white.withAlphaComponent(0.4))
            .font(Fonts.SFProDisplay.semiBold(size: 15.scale))
            .lineHeight(18.scale)
        
        let view = UILabel()
        view.attributedText = "Market.All".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeArrowView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Signals.Arrow")
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
