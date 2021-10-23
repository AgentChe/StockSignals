//
//  WatchListGroupsCollectionView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 23.10.2021.
//

import UIKit

final class WatchListGroupsCollectionView: UICollectionView {
    private lazy var elements = [WatchListGroupsCollectionElement]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension WatchListGroupsCollectionView {
    func setup(elements: [WatchListGroupsCollectionElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension WatchListGroupsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch elements[indexPath.row] {
        case .create:
            return dequeueReusableCell(withReuseIdentifier: String(describing: WatchListGroupsCollectionCreateCell.self), for: indexPath)
        case .group(let group):
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: WatchListGroupsCollectionCell.self), for: indexPath) as! WatchListGroupsCollectionCell
            cell.setup(element: group)
            return cell
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension WatchListGroupsCollectionView: UICollectionViewDelegateFlowLayout {
    
}

// MARK: Private
private extension WatchListGroupsCollectionView {
    func initialize() {
        register(WatchListGroupsCollectionCreateCell.self, forCellWithReuseIdentifier: String(describing: WatchListGroupsCollectionCreateCell.self))
        register(WatchListGroupsCollectionCell.self, forCellWithReuseIdentifier: String(describing: WatchListGroupsCollectionCell.self))
        
        dataSource = self
        delegate = self
    }
}
