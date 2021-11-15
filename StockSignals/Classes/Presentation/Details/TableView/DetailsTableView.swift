//
//  DetailsTableView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 15.11.2021.
//

import UIKit

final class DetailsTableView: UITableView {
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
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: Private
private extension DetailsTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        register(DetailsTableAboutCell.self, forCellReuseIdentifier: String(describing: DetailsTableAboutCell.self))
        
        dataSource = self
        delegate = self
    }
}
