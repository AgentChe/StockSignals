//
//  SignalsStocksCollectionView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.11.2021.
//

import UIKit

final class SignalsStocksCollectionView: UICollectionView {
    weak var mainDelegate: SignalsTableViewDelegate?
    
    private lazy var elements = [StockSignal]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension SignalsStocksCollectionView {
    func setup(elements: [StockSignal]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension SignalsStocksCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: SignalsStockCollectionCell.self), for: indexPath) as! SignalsStockCollectionCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension SignalsStocksCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainDelegate?.signalsTableDidSelect(stockSignal: elements[indexPath.row])
    }
}

// MARK: Private
private extension SignalsStocksCollectionView {
    func initialize() {
        register(SignalsStockCollectionCell.self, forCellWithReuseIdentifier: String(describing: SignalsStockCollectionCell.self))
        
        dataSource = self
        delegate = self
    }
}
