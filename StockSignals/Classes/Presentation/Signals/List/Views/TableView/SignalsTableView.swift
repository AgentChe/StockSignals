//
//  SignalsTableView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.11.2021.
//

import UIKit

protocol SignalsTableViewDelegate: AnyObject {
    func signalsTableViewDidSelect(element: SignalsTableElement)
}

final class SignalsTableView: UITableView {
    weak var mainDelegate: SignalsTableViewDelegate?
    
    private lazy var elements = [SignalsTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension SignalsTableView {
    func setup(elements: [SignalsTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension SignalsTableView: UITableViewDataSource {
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
        case .type(let type):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SignalsTableTypeCell.self)) as! SignalsTableTypeCell
            cell.setup(element: type)
            return cell
        case .stock(let signal):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SignalsTableStockCell.self)) as! SignalsTableStockCell
            cell.setup(element: signal)
            return cell
        case .optionCrypto(let signal):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SignalsTableOptionCryptoCell.self)) as! SignalsTableOptionCryptoCell
            cell.setup(element: signal)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension SignalsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return offset
        case .type:
            return 66.scale
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let element = elements[indexPath.row]
        mainDelegate?.signalsTableViewDidSelect(element: element)
    }
}

// MARK: Private
private extension SignalsTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        register(SignalsTableTypeCell.self, forCellReuseIdentifier: String(describing: SignalsTableTypeCell.self))
        register(SignalsTableStockCell.self, forCellReuseIdentifier: String(describing: SignalsTableStockCell.self))
        register(SignalsTableOptionCryptoCell.self, forCellReuseIdentifier: String(describing: SignalsTableOptionCryptoCell.self))
        
        dataSource = self
        delegate = self
    }
}
