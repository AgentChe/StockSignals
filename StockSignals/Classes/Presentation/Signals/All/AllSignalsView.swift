//
//  AllSignalsView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 04.11.2021.
//

import UIKit

final class AllSignalsView: UIView {
    lazy var sortButton = makeSortButton()
    lazy var tableView = makeTableView()
    lazy var sortView = makeSortView()
    
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
private extension AllSignalsView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
    }
}

// MARK: Make constraints
private extension AllSignalsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            sortButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            sortButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.scale),
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
private extension AllSignalsView {
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
