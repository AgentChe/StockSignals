//
//  SignalsView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.11.2021.
//

import UIKit

final class SignalsView: UIView {
    lazy var titleLabel = makeTitleLabel()
    lazy var filterView = makeFilterView()
    lazy var tableView = makeTableView()
    
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
private extension SignalsView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
    }
}

// MARK: Make constraints
private extension SignalsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 88.scale : 28.scale)
        ])
        
        NSLayoutConstraint.activate([
            filterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            filterView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            filterView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18.scale),
            filterView.heightAnchor.constraint(equalToConstant: 44.scale)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: filterView.bottomAnchor, constant: 8.scale),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension SignalsView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 34.scale))
            .lineHeight(41.scale)
        
        let view = UILabel()
        view.attributedText = "Signals.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeFilterView() -> SignalsFilterView {
        let view = SignalsFilterView()
        view.layer.cornerRadius = 12.scale
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(integralRed: 118, green: 118, blue: 124, alpha: 0.24)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTableView() -> SignalsTableView {
        let view = SignalsTableView()
        view.backgroundColor = UIColor.clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
