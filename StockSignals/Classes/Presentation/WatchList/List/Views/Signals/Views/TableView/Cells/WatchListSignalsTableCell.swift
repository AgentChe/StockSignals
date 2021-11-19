//
//  WatchListSignalsTableCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 22.10.2021.
//

import UIKit

final class WatchListSignalsTableCell: UITableViewCell {
    weak var mainDelegate: WatchListSignalsTableViewDelegate?
    
    lazy var collectionView = makeCollectionView()
    
    private var quotation: Quotation?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension WatchListSignalsTableCell {
    func setup(signal: Quotation) {
        quotation = signal
        
        let header = WatchListSignalCollectionHeader(imageUrl: signal.imageUrl,
                                                     symbol: signal.symbol,
                                                     company: signal.company)
        
        let section = WatchListSignalCollectionSection(header: header,
                                                       elements: [
                                                        .price(signal.price),
                                                        .change(signal.change),
                                                        .volume(signal.volume),
                                                        .peRatio(signal.peRatio),
                                                        .marketCap(signal.marketCap)
                                                       ])
 
        collectionView.setup(sections: [section])
    }
}

// MARK: Private
private extension WatchListSignalsTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        contentView.addGestureRecognizer(tapGesture)
        contentView.isUserInteractionEnabled = true
    }
    
    @objc
    func tapped() {
        guard let quotation = quotation else {
            return
        }
        
        mainDelegate?.watchListSignalsDidSelect(quotation: quotation)
    }
}

// MARK: Make constraints
private extension WatchListSignalsTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 37.scale),
            collectionView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension WatchListSignalsTableCell {
    func makeCollectionView() -> WatchListSignalCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 90.scale, height: 37.scale)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 32.scale
        layout.headerReferenceSize = CGSize(width: 160.scale, height: 37.scale)
        layout.sectionHeadersPinToVisibleBounds = true
        
        let view = WatchListSignalCollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
