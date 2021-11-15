//
//  SearchTableView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.11.2021.
//

import UIKit

protocol SearchTableViewDelegate: AnyObject {
    func searchTableViewDidTapped(type: SearchTableTypeElement)
    func searchTableViewDidTapped(symbol: String)
}

final class SearchTableView: UITableView {
    weak var searchDelegate: SearchTableViewDelegate?
    weak var listDelegate: SignalsTableViewDelegate?
    
    private lazy var elements = [SearchTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension SearchTableView {
    func setup(elements: [SearchTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension SearchTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch elements[indexPath.row] {
        case .type(let type):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SearchTableTypeCell.self)) as! SearchTableTypeCell
            cell.setup(element: type)
            return cell
        case .stockSignals(let elements):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SignalsTableStocksCollectionCell.self)) as! SignalsTableStocksCollectionCell
            cell.collectionView.mainDelegate = listDelegate
            cell.setup(elements: elements)
            return cell
        case .optionCryptoSignals(let elements):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SignalsTableOptionCryptoCollectionCell.self)) as! SignalsTableOptionCryptoCollectionCell
            cell.collectionView.mainDelegate = listDelegate
            cell.setup(elements: elements)
            return cell
        case .quotations(let quotations):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SearchTableQuotationCell.self)) as! SearchTableQuotationCell
            cell.collectionView.mainDelegate = searchDelegate
            cell.setup(element: quotations)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension SearchTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .type:
            return 66.scale
        case .stockSignals:
            return 235.scale
        case .optionCryptoSignals:
            return 288.scale
        case .quotations:
            return 146.scale
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case let .type(type) = elements[indexPath.row] else {
            return
        }
        
        searchDelegate?.searchTableViewDidTapped(type: type)
    }
}

// MARK: Private
private extension SearchTableView {
    func initialize() {
        register(SearchTableTypeCell.self, forCellReuseIdentifier: String(describing: SearchTableTypeCell.self))
        register(SignalsTableStocksCollectionCell.self, forCellReuseIdentifier: String(describing: SignalsTableStocksCollectionCell.self))
        register(SignalsTableOptionCryptoCollectionCell.self, forCellReuseIdentifier: String(describing: SignalsTableOptionCryptoCollectionCell.self))
        register(SearchTableQuotationCell.self, forCellReuseIdentifier: String(describing: SearchTableQuotationCell.self))
        
        dataSource = self
        delegate = self
    }
}
