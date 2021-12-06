//
//  MarketTableUserScreenersCollectionView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 06.12.2021.
//

import UIKit

final class MarketTableUserScreenersCollectionView: UICollectionView {
    lazy var elements = [UserScreener]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension MarketTableUserScreenersCollectionView {
    func setup(elements: [UserScreener]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension MarketTableUserScreenersCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: MarketTableUserScreenersCollectionCell.self), for: indexPath) as! MarketTableUserScreenersCollectionCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension MarketTableUserScreenersCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 311.scale, height: 363.scale)
    }
}

// MARK: Private
private extension MarketTableUserScreenersCollectionView {
    func initialize() {
        register(MarketTableUserScreenersCollectionCell.self, forCellWithReuseIdentifier: String(describing: MarketTableUserScreenersCollectionCell.self))
        
        dataSource = self
        delegate = self
    }
}
