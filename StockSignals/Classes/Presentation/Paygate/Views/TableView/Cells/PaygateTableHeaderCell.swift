//
//  PaygateTableHeaderCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 10.12.2021.
//

import UIKit

final class PaygateTableHeaderCell: UITableViewCell {
    lazy var headerView = makeImageView()
    lazy var text1Label = makeLabel()
    lazy var text2Label = makeLabel()
    lazy var text3Label = makeLabel()
    lazy var text4Label = makeLabel()
    
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
extension PaygateTableHeaderCell {
    func setup(element: PaygateTableHeader) {
        text1Label.attributedText = element.text1
            .uppercased()
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.black(size: 26.scale))
                            .lineHeight(27.scale)
                            .textAlignment(.center))
        
        text2Label.attributedText = element.text2
            .uppercased()
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 62, green: 89, blue: 223))
                            .font(Fonts.SFProDisplay.black(size: 26.scale))
                            .lineHeight(27.scale)
                            .textAlignment(.center))
        
        text3Label.attributedText = "Paygate.Text1".localized
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale)
                            .textAlignment(.center))
        
        text4Label.attributedText = "Paygate.Text2".localized
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.6))
                            .font(Fonts.SFProDisplay.regular(size: 17.scale))
                            .lineHeight(23.8.scale)
                            .textAlignment(.center))
    }
}

// MARK: Private
private extension PaygateTableHeaderCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension PaygateTableHeaderCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 226.scale)
        ])
        
        NSLayoutConstraint.activate([
            text1Label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            text1Label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 79.scale)
        ])
        
        NSLayoutConstraint.activate([
            text2Label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            text2Label.topAnchor.constraint(equalTo: text1Label.bottomAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            text3Label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            text3Label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            text3Label.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 25.scale)
        ])
        
        NSLayoutConstraint.activate([
            text4Label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            text4Label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            text4Label.topAnchor.constraint(equalTo: text3Label.bottomAnchor, constant: 8.scale),
            text4Label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PaygateTableHeaderCell {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.image = UIImage(named: "Paygate.Header")
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
