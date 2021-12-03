//
//  CSFiltersCollectionView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.12.2021.
//

import UIKit

final class CSFiltersCollectionView: UICollectionView {
    lazy var sections = [CSFiltersCollectionSection]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension CSFiltersCollectionView {
    func setup(sections: [CSFiltersCollectionSection]) {
        self.sections = sections
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension CSFiltersCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        count(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch element(for: indexPath) {
        case .signal(let element):
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: CSFiltersCollectionSignalCell.self), for: indexPath) as! CSFiltersCollectionSignalCell
            cell.setup(element: element)
            return cell
        case .filter(let element):
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: CSFiltersCollectionFilterCell.self), for: indexPath) as! CSFiltersCollectionFilterCell
            cell.setup(element: element)
            return cell
        case .signalMore:
            let cell =  dequeueReusableCell(withReuseIdentifier: String(describing: CSFiltersCollectionMoreCell.self), for: indexPath) as! CSFiltersCollectionMoreCell
            cell.setup(isLarge: false)
            return cell
        case .filterMore:
            let cell =  dequeueReusableCell(withReuseIdentifier: String(describing: CSFiltersCollectionMoreCell.self), for: indexPath) as! CSFiltersCollectionMoreCell
            cell.setup(isLarge: true)
            return cell
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension CSFiltersCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: CSFiltersCollectionHeaderView.self), for: indexPath) as! CSFiltersCollectionHeaderView
            headerView.setup(title: sections[indexPath.section].name)
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: frame.width, height: 59.scale)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch element(for: indexPath) {
        case .signal(let element):
            return CGSize(width: CSFiltersCollectionSignalCell.width(at: element), height: 34.scale)
        case .filter:
            return CGSize(width: 166.scale, height: 99.scale)
        case .signalMore:
            return CGSize(width: 57.scale, height: 34.scale)
        case .filterMore:
            return CGSize(width: 166.scale, height: 99.scale)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15.scale
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10.scale
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch element(for: indexPath) {
        case .signal(let element):
            signalTapped(indexPath: indexPath, element: element)
        case .filter:
            break
        case .signalMore:
            moreTapped(indexPath: indexPath)
        case .filterMore:
            moreTapped(indexPath: indexPath)
        }
    }
}

// MARK: Private
private extension CSFiltersCollectionView {
    func initialize() {
        register(CSFiltersCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: CSFiltersCollectionHeaderView.self))
        register(CSFiltersCollectionSignalCell.self, forCellWithReuseIdentifier: String(describing: CSFiltersCollectionSignalCell.self))
        register(CSFiltersCollectionFilterCell.self, forCellWithReuseIdentifier: String(describing: CSFiltersCollectionFilterCell.self))
        register(CSFiltersCollectionMoreCell.self, forCellWithReuseIdentifier: String(describing: CSFiltersCollectionMoreCell.self))
        
        dataSource = self
        delegate = self
    }
    
    func count(in section: Int) -> Int {
        let sec = sections[section]
        
        if sec.isExpanded {
            return sec.elements.count
        } else {
            return sec.elements.prefix(7).count + 1
        }
    }
    
    func element(for indexPath: IndexPath) -> CSFiltersCollectionElement {
        let section = sections[indexPath.section]
        
        if section.isExpanded {
            return section.elements[indexPath.row]
        }
        
        let countInSection = count(in: indexPath.section)
         
        if indexPath.row == (countInSection - 1) {
            return indexPath.section == 0 ? .signalMore : .filterMore
        } else {
            return section.elements[indexPath.row]
        }
    }
    
    func signalTapped(indexPath: IndexPath, element: CSFiltersCollectionSignalElement) {
        guard !element.isSelected else {
            return
        }
        
        var paths = [IndexPath]()
        
        let elements = sections[indexPath.section].elements

        let previousSelectedIndex = elements.firstIndex(where: { element -> Bool in
            guard case let .signal(filter) = element else {
                return false
            }

            return filter.isSelected
        })
        if let index = previousSelectedIndex {
            guard case let .signal(filter) = elements[index] else {
                return
            }

            filter.isSelected = false

            let path = IndexPath(row: index, section: indexPath.section)
            paths.append(path)
        }
        
        element.isSelected = true
        
        paths.append(indexPath)
        
        reloadItems(at: paths)
    }
    
    func moreTapped(indexPath: IndexPath) {
        sections[indexPath.section].isExpanded = true
        
        reloadSections([indexPath.section])
    }
}
