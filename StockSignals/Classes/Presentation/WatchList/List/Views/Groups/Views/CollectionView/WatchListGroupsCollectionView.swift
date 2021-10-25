//
//  WatchListGroupsCollectionView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 23.10.2021.
//

import UIKit

protocol WatchListGroupsCollectionViewDelegate: AnyObject {
    func watchListGroupDidTapped(element: WatchListGroupsCollectionElement)
    func watchListGroupDidRemoveTapped(element: WatchListGroupsCollectionGroupElement)
}

final class WatchListGroupsCollectionView: UICollectionView {
    weak var mainDelegate: WatchListGroupsCollectionViewDelegate?
    
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
    
    func add(element: WatchListGroupsCollectionElement) {
        elements.insert(element, at: 0)
        
        let path = IndexPath(row: 0, section: 0)
        
        insertItems(at: [path])
    }
    
    func remove(group: WatchListGroup) {
        let index = elements.firstIndex(where: { element -> Bool in
            guard case let .group(value) = element else {
                return false
            }
            
            return value.group.id == group.id
        })
        
        guard let index = index else {
            return
        }
        
        elements.remove(at: index)
        
        let path = IndexPath(row: index, section: 0)
        
        deleteItems(at: [path])
    }
    
    func change(isEditable: Bool) {
        elements.forEach { element in
            guard case let .group(value) = element else {
                return
            }
            
            value.isEditable = isEditable
        }
        
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
            cell.mainDelegate = mainDelegate
            cell.setup(element: group)
            return cell
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension WatchListGroupsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainDelegate?.watchListGroupDidTapped(element: elements[indexPath.row])
    }
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
