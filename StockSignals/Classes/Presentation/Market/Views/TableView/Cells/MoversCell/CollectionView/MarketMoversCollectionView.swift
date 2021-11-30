//
//  MarketMoversCollectionView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.11.2021.
//

import UIKit

final class MarketMoversCollectionView: UICollectionView {
    private lazy var elements = [MarketMoversCollectionElement]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension MarketMoversCollectionView {
    func setup(elements: [MarketMoversCollectionElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension MarketMoversCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: MarketMoversCollectionCell.self), for: indexPath) as! MarketMoversCollectionCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension MarketMoversCollectionView: UICollectionViewDelegateFlowLayout {
    
}

// MARK: Private
private extension MarketMoversCollectionView {
    func initialize() {
        register(MarketMoversCollectionCell.self, forCellWithReuseIdentifier: String(describing: MarketMoversCollectionCell.self))
        
        dataSource = self
        delegate = self
    }
}
