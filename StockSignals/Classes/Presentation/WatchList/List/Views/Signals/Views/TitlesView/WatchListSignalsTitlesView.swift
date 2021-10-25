//
//  WatchListSignalsTitlesView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 22.10.2021.
//

import UIKit

protocol WatchListSignalsTitlesViewDelegate: AnyObject {
    func watchListDidSelect(sort: WatchListSignalsSortElement)
}

final class WatchListSignalsTitlesView: UICollectionView {
    weak var scrollDelegate: WatchListSignalsScrollDelegate?
    weak var mainDelegate: WatchListSignalsTitlesViewDelegate?
    
    private lazy var elements: [WatchListSignalsTitlesElement] = [
        .price, .change, .volume, .peRatio, .marketCap
    ]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension WatchListSignalsTitlesView {
    func scroll(as scrollView: UIScrollView) {
        guard scrollView !== self else {
            return
        }
        
        bounds.origin = scrollView.contentOffset
    }
}

// MARK: UICollectionViewDataSource
extension WatchListSignalsTitlesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch elements[indexPath.row] {
        case .price:
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: WatchListSignalsTitlesWithIconCell.self), for: indexPath) as! WatchListSignalsTitlesWithIconCell
            cell.setup(title: "WatchList.Price".localized)
            return cell
        case .change:
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: WatchListSignalsTitlesWithIconCell.self), for: indexPath) as! WatchListSignalsTitlesWithIconCell
            cell.setup(title: "WatchList.Change".localized)
            return cell
        case .volume:
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: WatchListSignalsTitlesCell.self), for: indexPath) as! WatchListSignalsTitlesCell
            cell.setup(title: "WatchList.Volume".localized)
            return cell
        case .peRatio:
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: WatchListSignalsTitlesWithIconCell.self), for: indexPath) as! WatchListSignalsTitlesWithIconCell
            cell.setup(title: "WatchList.P/E".localized)
            return cell
        case .marketCap:
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: WatchListSignalsTitlesCell.self), for: indexPath) as! WatchListSignalsTitlesCell
            cell.setup(title: "WatchList.MarketCap".localized)
            return cell
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension WatchListSignalsTitlesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: WatchListSignalsTitlesHeader.self), for: indexPath)
        default:
            fatalError()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.watchListSignalsDidScroll(scrollView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch elements[indexPath.row] {
        case .price:
            mainDelegate?.watchListDidSelect(sort: .price)
        case .change:
            mainDelegate?.watchListDidSelect(sort: .change)
        case .peRatio:
            mainDelegate?.watchListDidSelect(sort: .peRatio)
        default:
            break
        }
    }
}

// MARK: Private
private extension WatchListSignalsTitlesView {
    func initialize() {
        register(WatchListSignalsTitlesCell.self, forCellWithReuseIdentifier: String(describing: WatchListSignalsTitlesCell.self))
        register(WatchListSignalsTitlesWithIconCell.self, forCellWithReuseIdentifier: String(describing: WatchListSignalsTitlesWithIconCell.self))
        register(WatchListSignalsTitlesHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: WatchListSignalsTitlesHeader.self))
        
        dataSource = self
        delegate = self
    }
}
