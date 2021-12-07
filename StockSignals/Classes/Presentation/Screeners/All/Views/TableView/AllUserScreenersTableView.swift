//
//  AllUserScreenersTableView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 07.12.2021.
//

import UIKit

protocol AllUserScreenersTableViewDelegate: AnyObject {
    func allUserScreenersDidSelect(symbol: String)
    func allUserScreenersDidSelect(seeAll: UserScreener)
}

final class AllUserScreenersTableView: UITableView {
    weak var mainDelegate: AllUserScreenersTableViewDelegate?
    
    private lazy var elements = [UserScreener]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension AllUserScreenersTableView {
    func setup(elements: [UserScreener]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension AllUserScreenersTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: String(describing: AllUserScreenersTableCell.self)) as! AllUserScreenersTableCell
        cell.mainDelegate = mainDelegate
        cell.setup(element: elements[indexPath.section])
        return cell
    }
}

// MARK: UITableViewDelegate
extension AllUserScreenersTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        16.scale
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.section].quotations.count {
        case 0:
            return 126.scale
        case 1:
            return 198.scale
        case 2:
            return 270.scale
        case 3:
            return 342.scale
        case 4:
            return 414.scale
        default:
            return 414.scale
        }
    }
}

// MARK: Private
private extension AllUserScreenersTableView {
    func initialize() {
        register(AllUserScreenersTableCell.self, forCellReuseIdentifier: String(describing: AllUserScreenersTableCell.self))
        
        dataSource = self
        delegate = self
    }
}
