//
//  WatchListSignalCollectionView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 22.10.2021.
//

import UIKit

final class WatchListSignalCollectionView: UICollectionView {
    private lazy var sections = [WatchListSignalCollectionSection]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Pubiic
extension WatchListSignalCollectionView {
    func setup(sections: [WatchListSignalCollectionSection]) {
        self.sections = sections
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension WatchListSignalCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: WatchListSignalCollectionCell.self), for: indexPath) as! WatchListSignalCollectionCell
        cell.setup(element: sections[indexPath.section].elements[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension WatchListSignalCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: WatchListSignalCollectionHeaderView.self), for: indexPath) as! WatchListSignalCollectionHeaderView
            header.setup(header: sections[indexPath.section].header)
            return header
        default:
            fatalError()
        }
    }
}

// MARK: Private
private extension WatchListSignalCollectionView {
    func initialize() {
        register(WatchListSignalCollectionCell.self, forCellWithReuseIdentifier: String(describing: WatchListSignalCollectionCell.self))
        register(WatchListSignalCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: WatchListSignalCollectionHeaderView.self))
        
        dataSource = self
        delegate = self
    }
}
