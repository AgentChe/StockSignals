//
//  PaygateTableView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 10.12.2021.
//

import UIKit

final class PaygateTableView: UITableView {
    private lazy var elements = [PaygateTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UITableViewDataSource
extension PaygateTableView {
    func setup(elements: [PaygateTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension PaygateTableView: UITableViewDataSource {
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
        case .header(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: PaygateTableHeaderCell.self)) as! PaygateTableHeaderCell
            cell.setup(element: element)
            return cell
        case .feature(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: PaygateTableFeatureCell.self)) as! PaygateTableFeatureCell
            cell.setup(element: element)
            return cell
        case .moreFeatures:
            return dequeueReusableCell(withIdentifier: String(describing: PaygateTableMoreFeaturesCell.self))!
        case .traders:
            return dequeueReusableCell(withIdentifier: String(describing: PaygateTableTradersCell.self))!
        }
    }
}

// MARK: UITableViewDelegate
extension PaygateTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return offset
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: Private
private extension PaygateTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        register(PaygateTableHeaderCell.self, forCellReuseIdentifier: String(describing: PaygateTableHeaderCell.self))
        register(PaygateTableFeatureCell.self, forCellReuseIdentifier: String(describing: PaygateTableFeatureCell.self))
        register(PaygateTableMoreFeaturesCell.self, forCellReuseIdentifier: String(describing: PaygateTableMoreFeaturesCell.self))
        register(PaygateTableTradersCell.self, forCellReuseIdentifier: String(describing: PaygateTableTradersCell.self))
        
        dataSource = self
        delegate = self
    }
}
