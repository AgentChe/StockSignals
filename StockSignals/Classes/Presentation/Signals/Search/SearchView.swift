//
//  SearchView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.11.2021.
//

import UIKit

final class SearchView: UIView {
    lazy var searchTextField = makeSearchField()
    lazy var cancelButton = makeCancelButton()
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
private extension SearchView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
    }
}

// MARK: Make constraints
private extension SearchView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -83.scale),
            searchTextField.heightAnchor.constraint(equalToConstant: 38.scale),
            searchTextField.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 52.scale : 32.scale)
        ])
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            cancelButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 4.scale),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension SearchView {
    func makeSearchField() -> PaddingTextField {
        let attrs = TextAttributes()
            .textColor(UIColor.white.withAlphaComponent(0.2))
            .font(Fonts.SFProDisplay.regular(size: 17.scale))
        
        let view = PaddingTextField()
        view.textPadding = UIEdgeInsets(top: 10.scale, left: 16.scale, bottom: 10.scale, right: 16.scale)
        view.attributedPlaceholder = "Search.SearchPlaceholder".localized.attributed(with: attrs)
        view.font = Fonts.SFProDisplay.regular(size: 15.scale)
        view.textColor = UIColor.white
        view.layer.cornerRadius = 10.scale
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCancelButton() -> TapAreaButton {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 62, green: 89, blue: 223))
            .font(Fonts.SFProDisplay.regular(size: 17.scale))
        
        let view = TapAreaButton()
        view.backgroundColor = UIColor.clear
        view.setAttributedTitle("Cancel".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTableView() -> SearchTableView {
        let view = SearchTableView()
        view.contentInset = UIEdgeInsets(top: 24.scale, left: 0, bottom: 24.scale, right: 0)
        view.backgroundColor = UIColor.clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
