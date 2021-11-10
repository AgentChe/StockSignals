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
    weak var mainDelegate: SearchTableViewDelegate?
    
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
        case .offset:
            let cell = dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))!
            cell.backgroundColor = UIColor.clear
            cell.contentView.backgroundColor = UIColor.clear
            cell.selectionStyle = .none
            return cell
        case .type(let type):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SearchTableTypeCell.self)) as! SearchTableTypeCell
            cell.setup(element: type)
            return cell
        case .stockSignal(let signal):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SignalsTableStockCell.self)) as! SignalsTableStockCell
            cell.setup(element: signal)
            return cell
        case .optionCryptoSignal(let signal):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SignalsTableOptionCryptoCell.self)) as! SignalsTableOptionCryptoCell
            cell.setup(element: signal)
            return cell
        case .quotations(let quotations):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SearchTableQuotationCell.self)) as! SearchTableQuotationCell
            cell.collectionView.mainDelegate = mainDelegate
            cell.setup(element: quotations)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension SearchTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return offset
        case .type:
            return 66.scale
        case .quotations:
            return 146.scale
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch elements[indexPath.row] {
        case .type(let type):
            mainDelegate?.searchTableViewDidTapped(type: type)
        case .stockSignal(let signal):
            mainDelegate?.searchTableViewDidTapped(symbol: signal.symbol)
        case .optionCryptoSignal(let signal):
            mainDelegate?.searchTableViewDidTapped(symbol: signal.symbol)
        default:
            return
        }
    }
}

// MARK: Private
private extension SearchTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        register(SearchTableTypeCell.self, forCellReuseIdentifier: String(describing: SearchTableTypeCell.self))
        register(SignalsTableStockCell.self, forCellReuseIdentifier: String(describing: SignalsTableStockCell.self))
        register(SignalsTableOptionCryptoCell.self, forCellReuseIdentifier: String(describing: SignalsTableOptionCryptoCell.self))
        register(SearchTableQuotationCell.self, forCellReuseIdentifier: String(describing: SearchTableQuotationCell.self))
        
        dataSource = self
        delegate = self
    }
}
