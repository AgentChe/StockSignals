//
//  SettingsTableView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 08.11.2021.
//

import UIKit

protocol SettingsTableViewDelegate: AnyObject {
    func settingsTableDidSelect(element: SettingsTableElement)
}

final class SettingsTableView: UITableView {
    weak var mainDelegate: SettingsTableViewDelegate?
    
    private lazy var elements = [SettingsTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension SettingsTableView {
    func setup(elements: [SettingsTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension SettingsTableView: UITableViewDataSource {
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
        case .notifications:
            return dequeueReusableCell(withIdentifier: String(describing: SettingsTableNotificationsCell.self))!
        case .rateApp:
            return dequeueReusableCell(withIdentifier: String(describing: SettingsTableRateAppCell.self))!
        case .privacyPolicy:
            return dequeueReusableCell(withIdentifier: String(describing: SettingsTablePrivacyPolicyCell.self))!
        case .terms:
            return dequeueReusableCell(withIdentifier: String(describing: SettingsTableTermsCell.self))!
        case .contactUs:
            return dequeueReusableCell(withIdentifier: String(describing: SettingsTableContactUsCell.self))!
        }
    }
}

// MARK: UITableViewDelegate
extension SettingsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainDelegate?.settingsTableDidSelect(element: elements[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return offset
        default:
            return 55.scale
        }
    }
}

// MARK: Private
private extension SettingsTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        register(SettingsTableNotificationsCell.self, forCellReuseIdentifier: String(describing: SettingsTableNotificationsCell.self))
        register(SettingsTableRateAppCell.self, forCellReuseIdentifier: String(describing: SettingsTableRateAppCell.self))
        register(SettingsTablePrivacyPolicyCell.self, forCellReuseIdentifier: String(describing: SettingsTablePrivacyPolicyCell.self))
        register(SettingsTableTermsCell.self, forCellReuseIdentifier: String(describing: SettingsTableTermsCell.self))
        register(SettingsTableContactUsCell.self, forCellReuseIdentifier: String(describing: SettingsTableContactUsCell.self))
        
        dataSource = self
        delegate = self
    }
}
