//
//  MarketQuotationsCollectionView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 01.12.2021.
//

import UIKit

final class MarketQuotationsKeysCollectionView: UICollectionView {
    var didSelect: ((MarketQuotationsKeysCollectionElement) -> Void)?
    
    private lazy var elements = [MarketQuotationsKeysCollectionElement]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension MarketQuotationsKeysCollectionView {
    func setup(elements: [MarketQuotationsKeysCollectionElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension MarketQuotationsKeysCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: MarketQuotationsKeysCollectionCell.self), for: indexPath) as! MarketQuotationsKeysCollectionCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension MarketQuotationsKeysCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !elements[indexPath.row].isSelected else {
            return
        }
        
        var paths = [IndexPath]()
        
        if let index = elements.firstIndex(where: { $0.isSelected }) {
            elements[index].isSelected = false
            
            let path = IndexPath(row: index, section: 0)
            paths.append(path)
        }
        
        elements[indexPath.row].isSelected = true
        
        paths.append(indexPath)
        
        reloadItems(at: paths)
        
        didSelect?(elements[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: MarketQuotationsKeysCollectionCell.width(for: elements[indexPath.row].title),
               height: 34.scale)
    }
}

// MARK: Private
private extension MarketQuotationsKeysCollectionView {
    func initialize() {
        register(MarketQuotationsKeysCollectionCell.self, forCellWithReuseIdentifier: String(describing: MarketQuotationsKeysCollectionCell.self))
        
        dataSource = self
        delegate = self
    }
}
