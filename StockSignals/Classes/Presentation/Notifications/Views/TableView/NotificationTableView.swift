//
//  NotificationTableView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.10.2021.
//

import UIKit

final class NotificationTableView: UITableView {
    private lazy var sections = [NotificationTableSection]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension NotificationTableView {
    func setup(sections: [NotificationTableSection]) {
        self.sections = sections
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension NotificationTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: String(describing: NotificationTableCell.self), for: indexPath) as! NotificationTableCell
        cell.setup(element: sections[indexPath.section].elements[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate
extension NotificationTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50.scale
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = dequeueReusableHeaderFooterView(withIdentifier: String(describing: NotificationTableHeaderView.self)) as! NotificationTableHeaderView
        header.setup(text: sections[section].title)
        return header
    }
}

// MARK: Private
private extension NotificationTableView {
    func initialize() {
        register(NotificationTableCell.self, forCellReuseIdentifier: String(describing: NotificationTableCell.self))
        register(NotificationTableHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: NotificationTableHeaderView.self))
        
        dataSource = self
        delegate = self
    }
}
