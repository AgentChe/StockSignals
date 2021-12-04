//
//  FiltersItemsView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.12.2021.
//

import UIKit

final class FiltersItemsView: UIView {
    lazy var separator = makeSeparator()
    lazy var titleLabel = makeTitleLabel()
    lazy var discardButton = makeDiscardButton()
    lazy var tableView = makeTableView()
    lazy var confirmButton = makeConfirmButton()
    
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
private extension FiltersItemsView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57)
    }
}

// MARK: Make constraints
private extension FiltersItemsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 4.scale),
            separator.widthAnchor.constraint(equalToConstant: 50.scale),
            separator.centerXAnchor.constraint(equalTo: centerXAnchor),
            separator.topAnchor.constraint(equalTo: topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 36.scale)
        ])
        
        NSLayoutConstraint.activate([
            discardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18.scale),
            discardButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1.scale),
            tableView.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -1.scale)
        ])
        
        NSLayoutConstraint.activate([
            confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            confirmButton.heightAnchor.constraint(equalToConstant: 60.scale),
            confirmButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -58.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension FiltersItemsView {
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        view.layer.cornerRadius = 2.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 234, green: 232, blue: 241))
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
            .lineHeight(22.8.scale)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = title.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeDiscardButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 62, green: 89, blue: 223))
            .font(Fonts.SFProDisplay.regular(size: 17.scale))
        
        let view = UIButton()
        view.setAttributedTitle("Filters.Discard".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTableView() -> FiltersItemsTableView {
        let view = FiltersItemsTableView()
        view.contentInset = UIEdgeInsets(top: 24.scale, left: 0, bottom: 24.scale, right: 0)
        view.backgroundColor = UIColor.clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeConfirmButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
        
        let view = UIButton()
        view.backgroundColor = UIColor(integralRed: 62, green: 89, blue: 223)
        view.layer.cornerRadius = 16.scale
        view.setAttributedTitle("Filters.Confirm".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
