//
//  WatchListGroupsView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 22.10.2021.
//

import UIKit
import RxSwift

final class WatchListGroupsView: UIView {
    lazy var collectionView = makeCollectionView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = WatchListGroupsViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewDidLoad() {
        viewModel.elements.drive(onNext: { [weak self] elements in
            self?.collectionView.setup(elements: elements)
        })
        .disposed(by: disposeBag)
        
        viewModel.removed.drive(onNext: { [weak self] group in
            self?.collectionView.remove(group: group)
        })
        .disposed(by: disposeBag)
    }
}

// MARK: Public
extension WatchListGroupsView {
    func remove(group: WatchListGroup) {
        viewModel.remove.accept(group)
    }
}

// MARK: Make constraints
private extension WatchListGroupsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension WatchListGroupsView {
    func makeCollectionView() -> WatchListGroupsCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 166.scale, height: 107.scale)
        layout.minimumInteritemSpacing = 11.scale
        layout.minimumLineSpacing = 16.scale
        
        let view = WatchListGroupsCollectionView(frame: .zero, collectionViewLayout: layout)
        view.contentInset = UIEdgeInsets(top: 16.scale, left: 16.scale, bottom: 0, right: 16.scale)
        view.backgroundColor = UIColor.clear
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
