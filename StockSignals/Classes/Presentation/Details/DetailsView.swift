//
//  DetailsView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.11.2021.
//

import UIKit

final class DetailsView: UIView {
    lazy var company: String? = nil {
        didSet {
            let attrs = TextAttributes()
                .textColor(UIColor.white)
                .font(Fonts.SFProDisplay.bold(size: 17.scale))
                .lineHeight(22.scale)
                .textAlignment(.center)
            companyLabel.attributedText = company?.attributed(with: attrs)
        }
    }
    
    lazy var companyLabel = makeCompanyLabel()
    lazy var backButton = makeBackButton()
    lazy var symbolLabel = makeSymbolLabel()
    lazy var favoriteButton = makeFavoriteButton()
    lazy var symbolView = makeTableView()
    lazy var filterView = makeFilterView()
    lazy var tableView = makeTableView()
    
    private let symbol: String
    
    init(symbol: String) {
        self.symbol = symbol
        
        super.init(frame: .zero)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension DetailsView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
    }
}

// MARK: Make constraints
private extension DetailsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 36.scale),
            backButton.heightAnchor.constraint(equalToConstant: 36.scale),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 49.scale : 49.scale)
        ])
        
        NSLayoutConstraint.activate([
            companyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            companyLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 47.scale : 47.scale)
        ])
        
        NSLayoutConstraint.activate([
            symbolLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            symbolLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.widthAnchor.constraint(equalToConstant: 36.scale),
            favoriteButton.heightAnchor.constraint(equalToConstant: 36.scale),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 49.scale : 49.scale)
        ])
        
        NSLayoutConstraint.activate([
            filterView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterView.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 13.scale),
            filterView.heightAnchor.constraint(equalToConstant: 34.scale)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: filterView.bottomAnchor, constant: 2.scale),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension DetailsView {
    func makeCompanyLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeBackButton() -> UIButton {
        let view = UIButton()
        view.setImage(UIImage(named: "Details.Back"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSymbolLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white.withAlphaComponent(0.4))
            .font(Fonts.SFProDisplay.bold(size: 15.scale))
            .lineHeight(22.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = symbol.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeFavoriteButton() -> UIButton {
        let view = UIButton()
        view.setImage(UIImage(named: "Details.Favorite.Deselected"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeFilterView() -> DetailsFilterView {
        let view = DetailsFilterView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTableView() -> DetailsTableView {
        let view = DetailsTableView()
        view.contentInset = UIEdgeInsets(top: 24.scale, left: 0, bottom: 24.scale, right: 0)
        view.backgroundColor = UIColor.clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
