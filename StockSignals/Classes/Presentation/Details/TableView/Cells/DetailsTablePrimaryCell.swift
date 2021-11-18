//
//  DetailsTablePrimaryCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 18.11.2021.
//

import UIKit

final class DetailsTablePrimaryCell: UITableViewCell {
    lazy var priceLabel = makeLabel()
    lazy var descrLabel = makeLabel()
    
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
extension DetailsTablePrimaryCell {
    func setup(element: DetailsPreMarket) {
        let priceAttrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 34.scale))
            .lineHeight(40.8.scale)
        priceLabel.attributedText = String(format: "$%@", String(element.price)).attributed(with: priceAttrs)
   
        let color: UIColor
        switch element.deltaIndicator {
        case .up:
            color = UIColor(integralRed: 129, green: 232, blue: 129)
        case .down:
            color = UIColor(integralRed: 235, green: 96, blue: 42)
        default:
            color = UIColor.white
        }
        let attrs = TextAttributes()
            .textColor(color)
            .font(Fonts.SFProDisplay.bold(size: 15.scale))
            .lineHeight(18.scale)
        descrLabel.attributedText = String(format: "%@ (%@)", String(element.netChange), element.percentChange).attributed(with: attrs)
    }
}

// MARK: Private
private extension DetailsTablePrimaryCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension DetailsTablePrimaryCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descrLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            descrLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            descrLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8.scale),
            descrLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension DetailsTablePrimaryCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
