//
//  AddToFavoriteTableCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 19.11.2021.
//

import UIKit

final class AddToFavoriteTableCell: UITableViewCell {
    lazy var label = makeLabel()
    lazy var iconView = makeIconView()
    
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
extension AddToFavoriteTableCell {
    func setup(element: AddToFavoriteTableElement) {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.regular(size: 17.scale))
            .lineHeight(23.8.scale)
        label.attributedText = element.group.name.attributed(with: attrs)
        
        iconView.image = UIImage(named: element.isFavorite ? "AddToFavorite.Selected" : "AddToFavorite.Deselected")
    }
}

// MARK: Private
private extension AddToFavoriteTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension AddToFavoriteTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -52.scale),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.scale),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.scale)
        ])
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 25.scale),
            iconView.heightAnchor.constraint(equalToConstant: 25.scale),
            iconView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.scale),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension AddToFavoriteTableCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
