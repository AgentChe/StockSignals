//
//  SearchTableQuotationCollectionView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.11.2021.
//

import UIKit

final class SearchTableQuotationCollectionView: UICollectionView {
    weak var mainDelegate: SearchTableViewDelegate?
    
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
extension SearchTableQuotationCollectionView {
    func setup(elements: [Quotation]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension SearchTableQuotationCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: SearchTableQuotationCollectionCell.self), for: indexPath) as! SearchTableQuotationCollectionCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension SearchTableQuotationCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 148.scale, height: 146.scale)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let symbol = elements[indexPath.row].symbol
        mainDelegate?.searchTableViewDidTapped(symbol: symbol)
    }
}

// MARK: Private
private extension SearchTableQuotationCollectionView {
    func initialize() {
        register(SearchTableQuotationCollectionCell.self, forCellWithReuseIdentifier: String(describing: SearchTableQuotationCollectionCell.self))
        
        dataSource = self
        delegate = self
    }
}
