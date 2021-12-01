//
//  MarketQuotationsCollectionView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 01.12.2021.
//

import UIKit

final class MarketQuotationsCollectionView: UICollectionView {
    private lazy var elements = [Quotation]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension MarketQuotationsCollectionView {
    func setup(elements: [Quotation]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension MarketQuotationsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: MarketQuotationsCollectionCell.self), for: indexPath) as! MarketQuotationsCollectionCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension MarketQuotationsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 148.scale, height: 146.scale)
    }
}

// MARK: Private
private extension MarketQuotationsCollectionView {
    func initialize() {
        register(MarketQuotationsCollectionCell.self, forCellWithReuseIdentifier: String(describing: MarketQuotationsCollectionCell.self))
        
        dataSource = self
        delegate = self
    }
}
