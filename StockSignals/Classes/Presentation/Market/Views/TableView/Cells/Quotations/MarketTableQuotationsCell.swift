//
//  MarketTableQuotationsCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 01.12.2021.
//

import UIKit

final class MarketTableQuotationsCell: UITableViewCell {
    lazy var keysCollectionView = makeKeysCollectionView()
    lazy var quotationsCollectionView = makeQuotationsCollectionView()
    
    private lazy var elements = [MarketTableQuotationsElement]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
        addSelectKeyAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension MarketTableQuotationsCell {
    func setup(elements: [MarketTableQuotationsElement]) {
        self.elements = elements
        
        let keys = elements.map { $0.key }
        keysCollectionView.setup(elements: keys)
        
        updateQuotations()
    }
}

// MARK: Private
private extension MarketTableQuotationsCell {
    func initialize() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    func addSelectKeyAction() {
        keysCollectionView.didSelect = { [weak self] element in
            self?.updateQuotations()
        }
    }
    
    func updateQuotations() {
        guard let element = elements.first(where: { $0.key.isSelected }) else {
            return
        }
        
        let quotations = element.quotations
        
        quotationsCollectionView.setup(elements: quotations)
    }
}

// MARK: Make constraints
private extension MarketTableQuotationsCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            keysCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            keysCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            keysCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            keysCollectionView.heightAnchor.constraint(equalToConstant: 34.scale)
        ])
        
        NSLayoutConstraint.activate([
            quotationsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            quotationsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            quotationsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            quotationsCollectionView.heightAnchor.constraint(equalToConstant: 146.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension MarketTableQuotationsCell {
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
        contentView.addSubview(view)
        return view
    }
    
    func makeQuotationsCollectionView() -> MarketQuotationsCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 12.scale
        
        let view = MarketQuotationsCollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.contentInset = UIEdgeInsets(top: 0, left: 16.scale, bottom: 0, right: 16.scale)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
