//
//  SearchAllSignalsView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 10.11.2021.
//

import UIKit

final class SearchAllSignalsView: UIView {
    lazy var backButton = makeBackButton()
    lazy var titleLabel = makeTitleLabel()
    lazy var sortButton = makeSortButton()
    lazy var tableView = makeTableView()
    lazy var sortView = makeSortView()
    
    private let title: String
    
    init(title: String) {
        self.title = title
        
        super.init(frame: .zero)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension SearchAllSignalsView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
    }
}

// MARK: Make constraints
private extension SearchAllSignalsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 36.scale),
            backButton.heightAnchor.constraint(equalToConstant: 36.scale),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 55.scale : 35.scale)
        ])
        
        NSLayoutConstraint.activate([
            sortButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            sortButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 27.scale),
            sortButton.heightAnchor.constraint(equalToConstant: 40.scale)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: sortButton.bottomAnchor, constant: 16.scale),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            sortView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sortView.trailingAnchor.constraint(equalTo: trailingAnchor),
            sortView.topAnchor.constraint(equalTo: topAnchor),
            sortView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension SearchAllSignalsView {
    func makeBackButton() -> UIButton {
        let view = UIButton()
        view.setImage(UIImage(named: "AllQuotations.Back"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
            .lineHeight(22.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = title.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSortButton() -> AllSignalsSortButton {
        let view = AllSignalsSortButton()
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        view.layer.cornerRadius = 10.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTableView() -> SignalsTableView {
        let view = SignalsTableView()
        view.contentInset = UIEdgeInsets(top: 16.scale, left: 0, bottom: 16.scale, right: 0)
        view.backgroundColor = UIColor.clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSortView() -> AllSignalsSortView {
        let view = AllSignalsSortView()
        view.isHidden = true
        view.backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
