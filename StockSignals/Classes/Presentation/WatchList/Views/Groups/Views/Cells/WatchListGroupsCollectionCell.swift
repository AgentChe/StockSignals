//
//  WatchListGroupsCollectionCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 23.10.2021.
//

import UIKit

final class WatchListGroupsCollectionCell: UICollectionViewCell {
    lazy var container = makeContainer()
    lazy var nameLabel = makeLabel()
    lazy var countLabel = makeLabel()
    
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
extension WatchListGroupsCollectionCell {
    func setup(element: WatchListGroup) {
        nameLabel.attributedText = element.name
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        
        let count = String(format: "WatchList.Groups.Count".localized, element.signals.count)
        countLabel.attributedText = count
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.4))
                            .font(Fonts.SFProDisplay.regular(size: 17.scale))
                            .lineHeight(20.4.scale))
    }
}

// MARK: Private
private extension WatchListGroupsCollectionCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectedView
    }
}

// MARK: Make constraints
private extension WatchListGroupsCollectionCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.scale),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.scale),
            nameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.scale),
            countLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.scale),
            countLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -9.scale)
        ])
    }
}

// MARK: Lazy initializattion
private extension WatchListGroupsCollectionCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 16.scale
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
