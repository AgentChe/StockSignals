//
//  DetailsTableView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.11.2021.
//

import UIKit

protocol DetailsTableViewDelegate: AnyObject {
    func detailsTableViewDidTappedUnlockAnalytics()
}

final class DetailsTableView: UITableView {
    weak var mainDelegate: DetailsTableViewDelegate?
    
    private lazy var elements = [DetailsTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension DetailsTableView {
    func setup(elements: [DetailsTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension DetailsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch elements[indexPath.row] {
        case .offset:
            let cell = dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
            cell.contentView.backgroundColor = UIColor.clear
            cell.backgroundColor = UIColor.clear
            cell.selectionStyle = .none
            return cell
        case .title(let title):
            let cell = dequeueReusableCell(withIdentifier: String(describing: DetailsTableOverviewTitleCell.self)) as! DetailsTableOverviewTitleCell
            cell.setup(title: title)
            return cell
        case .primary(let primary):
            let cell = dequeueReusableCell(withIdentifier: String(describing: DetailsTablePrimaryCell.self)) as! DetailsTablePrimaryCell
            cell.setup(element: primary)
            return cell
        case .preMarket(let preMarket):
            let cell = dequeueReusableCell(withIdentifier: String(describing: DetailsTablePreMarketCell.self)) as! DetailsTablePreMarketCell
            cell.setup(element: preMarket)
            return cell
        case .chart(let cell):
            return cell
        case .analytics(let analytics):
            let cell = dequeueReusableCell(withIdentifier: String(describing: DetailsTableAnalyticsCell.self)) as! DetailsTableAnalyticsCell
            cell.setup(element: analytics)
            return cell
        case .unlockAnalytics:
            let cell = dequeueReusableCell(withIdentifier: String(describing: DetailsTableUnlockAnalyticsCell.self)) as! DetailsTableUnlockAnalyticsCell
            cell.mainDelegate = mainDelegate
            return cell
        case .signals(let signals):
            let cell = dequeueReusableCell(withIdentifier: String(describing: DetailsTableSignalsCell.self)) as! DetailsTableSignalsCell
            cell.setup(elements: signals)
            return cell
        case .summary(let title, let value):
            let cell = dequeueReusableCell(withIdentifier: String(describing: DetailsTableSummaryCell.self)) as! DetailsTableSummaryCell
            cell.setup(title: title, value: value)
            return cell
        case .aboutCompany(let text):
            let cell = dequeueReusableCell(withIdentifier: String(describing: DetailsTableAboutCell.self)) as! DetailsTableAboutCell
            cell.setup(text: text)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension DetailsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return offset
        case .signals:
            return 235.scale
        case .unlockAnalytics:
            return 163.scale
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: Private
private extension DetailsTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        register(DetailsTablePrimaryCell.self, forCellReuseIdentifier: String(describing: DetailsTablePrimaryCell.self))
        register(DetailsTablePreMarketCell.self, forCellReuseIdentifier: String(describing: DetailsTablePreMarketCell.self))
        register(DetailsTableAnalyticsCell.self, forCellReuseIdentifier: String(describing: DetailsTableAnalyticsCell.self))
        register(DetailsTableSignalsCell.self, forCellReuseIdentifier: String(describing: DetailsTableSignalsCell.self))
        register(DetailsTableOverviewTitleCell.self, forCellReuseIdentifier: String(describing: DetailsTableOverviewTitleCell.self))
        register(DetailsTableSummaryCell.self, forCellReuseIdentifier: String(describing: DetailsTableSummaryCell.self))
        register(DetailsTableAboutCell.self, forCellReuseIdentifier: String(describing: DetailsTableAboutCell.self))
        register(DetailsTableUnlockAnalyticsCell.self, forCellReuseIdentifier: String(describing: DetailsTableUnlockAnalyticsCell.self))
        
        dataSource = self
        delegate = self
    }
}
