//
//  OnbStocksCollectionView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 28.10.2021.
//

import UIKit

protocol OnbStocksCollectionViewDelegate: AnyObject {
    func stocksCollectionDidChangeSelection()
}

final class OnbStocksCollectionView: UICollectionView {
    weak var mainDelegate: OnbStocksCollectionViewDelegate?
    
    lazy var elements = [OnbStocksCollectionElement]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension OnbStocksCollectionView {
    func setup(elements: [OnbStocksCollectionElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension OnbStocksCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: OnbStocksCollectionCell.self), for: indexPath) as! OnbStocksCollectionCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        elements[indexPath.row].isSelected.toggle()
        
        reloadItems(at: [indexPath])
        
        mainDelegate?.stocksCollectionDidChangeSelection()
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension OnbStocksCollectionView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 156.scale, height: 156.scale)
    }
}

// MARK: Private
private extension OnbStocksCollectionView {
    func initialize() {
        register(OnbStocksCollectionCell.self, forCellWithReuseIdentifier: String(describing: OnbStocksCollectionCell.self))
        
        dataSource = self
        delegate = self
    }
}
