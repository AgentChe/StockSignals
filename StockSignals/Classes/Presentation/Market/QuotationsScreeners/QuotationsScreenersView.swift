//
//  QuotationsScreenersView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 01.12.2021.
//

import UIKit

final class QuotationsScreenersView: UIView {
    lazy var keysCollectionView = makeKeysCollectionView()
    lazy var titlesView = makeTitlesView()
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
private extension QuotationsScreenersView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
    }
}

// MARK: Make constraints
private extension QuotationsScreenersView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            keysCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            keysCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            keysCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 104.scale),
            keysCollectionView.heightAnchor.constraint(equalToConstant: 34.scale)
        ])
        
        NSLayoutConstraint.activate([
            titlesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titlesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titlesView.topAnchor.constraint(equalTo: keysCollectionView.bottomAnchor, constant: 32.scale),
            titlesView.heightAnchor.constraint(equalToConstant: 37.scale)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: titlesView.bottomAnchor, constant: 32.scale),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension QuotationsScreenersView {
    func makeKeysCollectionView() -> MarketQuotationsKeysCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 8.scale
        
        let view = MarketQuotationsKeysCollectionView(frame: .zero, collectionViewLayout: layout)
        view.contentInset = UIEdgeInsets(top: 0, left: 8.scale, bottom: 0, right: 8.scale)
        view.backgroundColor = UIColor.clear
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitlesView() -> WatchListSignalsTitlesView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 90.scale, height: 37.scale)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 32.scale
        layout.headerReferenceSize = CGSize(width: 160.scale, height: 37.scale)
        layout.sectionHeadersPinToVisibleBounds = true
        
        let view = WatchListSignalsTitlesView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTableView() -> WatchListSignalsTableView {
        let view = WatchListSignalsTableView()
        view.backgroundColor = UIColor.clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
