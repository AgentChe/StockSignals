//
//  SignalsTableView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.11.2021.
//

import UIKit

protocol SignalsTableViewDelegate: AnyObject {
    func signalsTableDidSelect(type: SignalType)
    func signalsTableDidSelect(stockSignal: StockSignal)
    func signalsTableDidSelect(optionCryptoSignal: OptionCryptoSignal)
}

final class SignalsTableView: UITableView {
    weak var mainDelegate: SignalsTableViewDelegate?
    
    private lazy var elements = [SignalsTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension SignalsTableView {
    func setup(elements: [SignalsTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension SignalsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch elements[indexPath.row] {
        case .type(let type):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SignalsTableTypeCell.self)) as! SignalsTableTypeCell
            cell.setup(element: type)
            return cell
        case .stocksCollection(let elements):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SignalsTableStocksCollectionCell.self)) as! SignalsTableStocksCollectionCell
            cell.collectionView.mainDelegate = mainDelegate
            cell.setup(elements: elements)
            return cell
        case .optionsCryptoCollection(let elements):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SignalsTableOptionCryptoCollectionCell.self)) as! SignalsTableOptionCryptoCollectionCell
            cell.collectionView.mainDelegate = mainDelegate
            cell.setup(elements: elements)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension SignalsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .type:
            return 66.scale
        case .stocksCollection:
            return 235.scale
        case .optionsCryptoCollection:
            return 288.scale
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case let .type(type) = elements[indexPath.row] else {
            return
        }
        
        mainDelegate?.signalsTableDidSelect(type: type)
    }
}

// MARK: Private
private extension SignalsTableView {
    func initialize() {
        register(SignalsTableTypeCell.self, forCellReuseIdentifier: String(describing: SignalsTableTypeCell.self))
        register(SignalsTableStocksCollectionCell.self, forCellReuseIdentifier: String(describing: SignalsTableStocksCollectionCell.self))
        register(SignalsTableOptionCryptoCollectionCell.self, forCellReuseIdentifier: String(describing: SignalsTableOptionCryptoCollectionCell.self))
        
        dataSource = self
        delegate = self
    }
}
