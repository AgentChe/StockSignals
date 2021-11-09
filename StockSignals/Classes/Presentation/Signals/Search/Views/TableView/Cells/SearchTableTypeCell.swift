//
//  SearchTableTypeCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.11.2021.
//

import UIKit

final class SearchTableTypeCell: UITableViewCell {
    lazy var titleLabel = makeTitleLabel()
    lazy var allLabel = makeAllLabel()
    lazy var arrowView = makeArrowView()
    
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
extension SearchTableTypeCell {
    func setup(element: SearchTableTypeElement) {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
            .lineHeight(22.8.scale)
        titleLabel.attributedText = title(at: element).attributed(with: attrs)
    }
}

// MARK: Private
private extension SearchTableTypeCell {
    func initialize() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    func title(at type: SearchTableTypeElement) -> String {
        switch type {
        case .stockSignals:
            return "Search.StockSignals".localized
        case .optionSignals:
            return "Search.OptionSignals".localized
        case .cryptoSignals:
            return "Search.CryptoSignals".localized
        case .stockQuotations:
            return "Search.StockQuotations".localized
        case .optionQuotations:
            return "Search.OptionQuotations".localized
        case .cryptoQuotations:
            return "Search.CryptoQuotations".localized
        }
    }
}

// MARK: Make constraints
private extension SearchTableTypeCell {
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
private extension SearchTableTypeCell {
    func makeTitleLabel() -> UILabel {
        let view = UILabel()
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
        view.attributedText = "Signals.All".localized.attributed(with: attrs)
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
