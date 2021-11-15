//
//  SignalsOptionCryptoCollectionView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.11.2021.
//

import UIKit

final class SignalsOptionCryptoCollectionView: UICollectionView {
    weak var mainDelegate: SignalsTableViewDelegate?
    
    private lazy var elements = [OptionCryptoSignal]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension SignalsOptionCryptoCollectionView {
    func setup(elements: [OptionCryptoSignal]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension SignalsOptionCryptoCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: SignalsOptionCryptoCollectionCell.self), for: indexPath) as! SignalsOptionCryptoCollectionCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension SignalsOptionCryptoCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainDelegate?.signalsTableDidSelect(optionCryptoSignal: elements[indexPath.row])
    }
}

// MARK: Private
private extension SignalsOptionCryptoCollectionView {
    func initialize() {
        register(SignalsOptionCryptoCollectionCell.self, forCellWithReuseIdentifier: String(describing: SignalsOptionCryptoCollectionCell.self))
        
        dataSource = self
        delegate = self
    }
}
