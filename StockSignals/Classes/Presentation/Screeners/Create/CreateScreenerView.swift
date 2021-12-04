//
//  CreateScreenerView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.12.2021.
//

import UIKit

final class CreateScreenerView: UIView {
    lazy var collectionView = makeCollectionView()
    lazy var button = makeButton()
    
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
private extension CreateScreenerView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
    }
}

// MARK: Make constraints
private extension CreateScreenerView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24.scale),
            button.heightAnchor.constraint(equalToConstant: 55.scale),
            button.widthAnchor.constraint(equalToConstant: 207.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension CreateScreenerView {
    func makeCollectionView() -> CSFiltersCollectionView {
        let layout = CSFiltersCollectionLayout()
        layout.scrollDirection = .vertical
        
        let view = CSFiltersCollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.contentInset = UIEdgeInsets(top: 0, left: 16.scale, bottom: 90.scale, right: 16.scale)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
        
        let view = UIButton()
        view.isHidden = true
        view.setAttributedTitle("CreateScreener.ViewResults".localized.attributed(with: attrs), for: .normal)
        view.layer.cornerRadius = 16.scale
        view.backgroundColor = UIColor(integralRed: 238, green: 142, blue: 72)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
