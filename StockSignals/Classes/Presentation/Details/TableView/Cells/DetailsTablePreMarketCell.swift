//
//  DetailsTablePreMarketCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 18.11.2021.
//

import UIKit

final class DetailsTablePreMarketCell: UITableViewCell {
    lazy var label = makeLabel()
    
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
extension DetailsTablePreMarketCell {
    func setup(element: DetailsPreMarket) {
        let titleAttrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 15.scale))
            .lineHeight(18.scale)
        let title = "Details.PreMarket".localized.attributed(with: titleAttrs)
   
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
        let value = String(format: "%@ %@ (%@)", String(element.price), String(element.netChange), element.percentChange).attributed(with: attrs)
        
        let string = NSMutableAttributedString()
        string.append(title)
        string.append(value)
        
        label.attributedText = string
    }
}

// MARK: Private
private extension DetailsTablePreMarketCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension DetailsTablePreMarketCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension DetailsTablePreMarketCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
