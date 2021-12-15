//
//  PaygateReviewsView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 14.12.2021.
//

import UIKit

final class PaygateReviewsView: UICollectionView {
    private lazy var elements = PaygateReviewsElement.makeCollection()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UICollectionViewDataSource
extension PaygateReviewsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: PaygateReviewsCell.self), for: indexPath) as! PaygateReviewsCell
        cell.setup(element: elements[indexPath.row % elements.count])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension PaygateReviewsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 249.scale, height: 124.scale)
    }
}

// MARK: Private
private extension PaygateReviewsView {
    func initialize() {
        register(PaygateReviewsCell.self, forCellWithReuseIdentifier: String(describing: PaygateReviewsCell.self))
        
        dataSource = self
        delegate = self
    }
}
