//
//  DetailsTableSignalsCollectionView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 16.11.2021.
//

import UIKit

final class DetailsTableSignalsCollectionView: UICollectionView {
    private lazy var elements = [DetailsTableSignal]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension DetailsTableSignalsCollectionView {
    func setup(elements: [DetailsTableSignal]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension DetailsTableSignalsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: DetailsTableSignalsCollectionCell.self), for: indexPath) as! DetailsTableSignalsCollectionCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: Private
private extension DetailsTableSignalsCollectionView {
    func initialize() {
        register(DetailsTableSignalsCollectionCell.self, forCellWithReuseIdentifier: String(describing: DetailsTableSignalsCollectionCell.self))
        
        dataSource = self
    }
}
