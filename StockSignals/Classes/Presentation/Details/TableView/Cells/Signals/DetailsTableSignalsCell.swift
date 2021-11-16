//
//  DetailsTableSignalCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 16.11.2021.
//

import UIKit

final class DetailsTableSignalsCell: UITableViewCell {
    lazy var collectionView = makeCollectionView()
    
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
extension DetailsTableSignalsCell {
    func setup(elements: [DetailsTableSignal]) {
        collectionView.setup(elements: elements)
    }
}

// MARK: Private
private extension DetailsTableSignalsCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension DetailsTableSignalsCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension DetailsTableSignalsCell {
    func makeCollectionView() -> DetailsTableSignalsCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 12.scale
        layout.itemSize = CGSize(width: 331.scale, height: 235.scale)
        
        let view = DetailsTableSignalsCollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = UIColor.clear
        view.contentInset = UIEdgeInsets(top: 0, left: 16.scale, bottom: 0, right: 16.scale)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}

