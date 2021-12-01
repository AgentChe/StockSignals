//
//  MarketTableView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.11.2021.
//

import UIKit

final class MarketTableView: UITableView {
    private lazy var elements = [MarketTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension MarketTableView {
    func setup(elements: [MarketTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension MarketTableView: UITableViewDataSource {
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
        case .movers(let elements):
            let cell = dequeueReusableCell(withIdentifier: String(describing: MarketTableMoversCell.self)) as! MarketTableMoversCell
            cell.setup(elements: elements)
            return cell
        case .allScreeners:
            return dequeueReusableCell(withIdentifier: String(describing: MarketTableAllScreenersCell.self))!
        case .quotations(let elements):
            let cell = dequeueReusableCell(withIdentifier: String(describing: MarketTableQuotationsCell.self)) as! MarketTableQuotationsCell
            cell.setup(elements: elements)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension MarketTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return offset
        case .movers:
            return 231.scale
        case .allScreeners:
            return 79.scale
        case .quotations:
            return 200.scale
        }
    }
}

// MARK: Private
private extension MarketTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        register(MarketTableMoversCell.self, forCellReuseIdentifier: String(describing: MarketTableMoversCell.self))
        register(MarketTableAllScreenersCell.self, forCellReuseIdentifier: String(describing: MarketTableAllScreenersCell.self))
        register(MarketTableQuotationsCell.self, forCellReuseIdentifier: String(describing: MarketTableQuotationsCell.self))
        
        dataSource = self
        delegate = self
    }
}
