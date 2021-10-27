//
//  IndustriesCollectionView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 28.10.2021.
//

import UIKit

protocol IndustriesCollectionViewDelegate: AnyObject {
    func industriesCollectionDidChangeSelection()
}

final class IndustriesCollectionView: UICollectionView {
    weak var mainDelegate: IndustriesCollectionViewDelegate?
    
    lazy var elements = [IndustriesCollectionElement]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension IndustriesCollectionView {
    func setup(elements: [IndustriesCollectionElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension IndustriesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: IndustriesCollectionCell.self), for: indexPath) as! IndustriesCollectionCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        elements[indexPath.row].isSelected.toggle()
        
        reloadItems(at: [indexPath])
        
        mainDelegate?.industriesCollectionDidChangeSelection()
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension IndustriesCollectionView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let element = elements[indexPath.row]
        return IndustriesCollectionCell.size(for: element)
    }
}

// MARK: Private
private extension IndustriesCollectionView {
    func initialize() {
        register(IndustriesCollectionCell.self, forCellWithReuseIdentifier: String(describing: IndustriesCollectionCell.self))
        
        dataSource = self
        delegate = self
    }
}
