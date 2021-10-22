//
//  WatchListSignalsTableView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 22.10.2021.
//

import UIKit

final class WatchListSignalsTableView: UITableView {
    private lazy var elements = [WatchListSignal]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension WatchListSignalsTableView {
    func setup(elements: [WatchListSignal]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension WatchListSignalsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: String(describing: WatchListSignalsTableCell.self)) as! WatchListSignalsTableCell
        cell.setup(signal: elements[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate
extension WatchListSignalsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        62.scale
    }
}

// MARK: Private
private extension WatchListSignalsTableView {
    func initialize() {
        register(WatchListSignalsTableCell.self, forCellReuseIdentifier: String(describing: WatchListSignalsTableCell.self))
        
        dataSource = self
        delegate = self
    }
}
