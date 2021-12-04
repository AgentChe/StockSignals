//
//  FiltersItemsTableView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.12.2021.
//

import UIKit

final class FiltersItemsTableView: UITableView {
    lazy var elements = [FiltersItemsTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension FiltersItemsTableView {
    func setup(elements: [FiltersItemsTableElement]) {
        self.elements = elements
        
        reloadData()
    }
    
    func discard() {
        if let index = elements.firstIndex(where: { $0.isSelected }) {
            elements[index].isSelected = false
            
            reloadSections([index], with: .automatic)
        }
    }
}

// MARK: UITableViewDataSource
extension FiltersItemsTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: String(describing: FiltersItemsTableCell.self)) as! FiltersItemsTableCell
        cell.setup(element: elements[indexPath.section])
        return cell
    }
}

// MARK: UITableViewDelegate
extension FiltersItemsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        24.scale
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !elements[indexPath.section].isSelected else {
            return
        }
        
        var sections = IndexSet()
        
        if let index = elements.firstIndex(where: { $0.isSelected }) {
            elements[index].isSelected = false
            sections.insert(index)
        }
        
        elements[indexPath.section].isSelected = true
        sections.insert(indexPath.section)
        
        reloadSections(sections, with: .automatic)
    }
}

// MARK: Private
private extension FiltersItemsTableView {
    func initialize() {
        register(FiltersItemsTableCell.self, forCellReuseIdentifier: String(describing: FiltersItemsTableCell.self))
        
        dataSource = self
        delegate = self
    }
}
