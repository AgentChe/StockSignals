//
//  NotificationTableHeaderView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 01.11.2021.
//

import UIKit

final class NotificationTableHeaderView: UITableViewHeaderFooterView {
    lazy var label = makeLabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension NotificationTableHeaderView {
    func setup(text: String) {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
            .lineHeight(26.6.scale)
        label.attributedText = text.attributed(with: attrs)
    }
}

// MARK: Private
private extension NotificationTableHeaderView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
        contentView.backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
        
        let view = UIView(frame: bounds)
        view.backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
        backgroundView = view
    }
}

// MARK: Make constraints
private extension NotificationTableHeaderView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension NotificationTableHeaderView {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}

