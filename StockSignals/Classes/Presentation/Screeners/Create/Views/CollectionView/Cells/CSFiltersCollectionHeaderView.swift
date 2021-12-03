//
//  CSFiltersCollectionHeaderView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.12.2021.
//

import UIKit

final class CSFiltersCollectionHeaderView: UICollectionReusableView {
    lazy var label = makeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
extension CSFiltersCollectionHeaderView {
    func setup(title: String) {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
            .lineHeight(26.6.scale)
        label.attributedText = title.attributed(with: attrs)
    }
}

// MARK: Private
private extension CSFiltersCollectionHeaderView {
    func initialize() {
        backgroundColor = UIColor.clear
    }
}

// MARK: Make constraints
private extension CSFiltersCollectionHeaderView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension CSFiltersCollectionHeaderView {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
