//
//  AllSignalsTableView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.11.2021.
//

import UIKit

protocol AllSignalsTableViewDelegate: AnyObject {
    func allSignalsTableDidSelect(symbol: String)
}

final class AllSignalsTableView: UITableView {
    weak var mainDelegate: AllSignalsTableViewDelegate?
    
    private lazy var elements = [AllSignalsTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension AllSignalsTableView {
    func setup(elements: [AllSignalsTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension AllSignalsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch elements[indexPath.row] {
        case .offset:
            let cell = dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))!
            cell.contentView.backgroundColor = UIColor.clear
            cell.backgroundColor = UIColor.clear
            cell.selectionStyle = .none
            return cell
        case .stock(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: AllSignalsTableStockCell.self)) as! AllSignalsTableStockCell
            cell.setup(element: element)
            return cell
        case .optionCrypto(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: AllSignalsTableOptionCryptoCell.self)) as! AllSignalsTableOptionCryptoCell
            cell.setup(element: element)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension AllSignalsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return offset
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch elements[indexPath.row] {
        case .stock(let signal):
            mainDelegate?.allSignalsTableDidSelect(symbol: signal.symbol)
        case .optionCrypto(let signal):
            mainDelegate?.allSignalsTableDidSelect(symbol: signal.symbol)
        default:
            break
        }
    }
}

// MARK: Private
private extension AllSignalsTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        register(AllSignalsTableStockCell.self, forCellReuseIdentifier: String(describing: AllSignalsTableStockCell.self))
        register(AllSignalsTableOptionCryptoCell.self, forCellReuseIdentifier: String(describing: AllSignalsTableOptionCryptoCell.self))
        
        dataSource = self
        delegate = self
    }
}
