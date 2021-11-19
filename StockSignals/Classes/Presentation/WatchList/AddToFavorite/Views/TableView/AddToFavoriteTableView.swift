//
//  AddToFavoriteTableView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 19.11.2021.
//

import UIKit

protocol AddToFavoriteTableViewDelegate: AnyObject {
    func addToFavoriteDidSelect(element: AddToFavoriteTableElement)
}

final class AddToFavoriteTableView: UITableView {
    weak var mainDelegate: AddToFavoriteTableViewDelegate?
    
    private lazy var elements = [AddToFavoriteTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension AddToFavoriteTableView {
    func setup(elements: [AddToFavoriteTableElement]) {
        self.elements = elements
        
        reloadData()
    }
    
    func replace(element: AddToFavoriteTableElement) {
        guard let index = elements.firstIndex(where: { $0.group.id == element.group.id }) else {
            return
        }
        
        elements[index] = element
        
        let path = IndexPath(row: index, section: 0)
        
        reloadRows(at: [path], with: .automatic)
    }
}

// MARK: UITableViewDataSource
extension AddToFavoriteTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: String(describing: AddToFavoriteTableCell.self)) as! AddToFavoriteTableCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate
extension AddToFavoriteTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainDelegate?.addToFavoriteDidSelect(element: elements[indexPath.row])
    }
}

// MARK: Private
private extension AddToFavoriteTableView {
    func initialize() {
        register(AddToFavoriteTableCell.self, forCellReuseIdentifier: String(describing: AddToFavoriteTableCell.self))
        
        dataSource = self
        delegate = self
    }
}
