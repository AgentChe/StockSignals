//
//  NotificationTableCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 01.11.2021.
//

import UIKit
import Kingfisher

final class NotificationTableCell: UITableViewCell {
    lazy var container = makeContainer()
    lazy var iconView = makeIconView()
    lazy var titleLabel = makeTitleLabel()
    lazy var descriptionLabel = makeDescriptionLabel()
    lazy var dateLabel = makeDateLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension NotificationTableCell {
    func setup(element: Notification) {
        iconView.kf.cancelDownloadTask()
        iconView.image = nil
        
        if let url = URL(string: element.imageUrl) {
            iconView.kf.setImage(with: url)
        }
        
        titleLabel.attributedText = element.title
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.bold(size: 17.scale))
                            .lineHeight(23.8.scale))
        
        descriptionLabel.attributedText = element.description
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.5))
                            .font(Fonts.SFProDisplay.regular(size: 17.scale))
                            .lineHeight(23.8.scale))
        
        dateLabel.attributedText = date(at: element.created)
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.5))
                            .font(Fonts.SFProDisplay.regular(size: 15.scale))
                            .lineHeight(20.scale))
    }
}

// MARK: Private
private extension NotificationTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    func date(at timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, HH:mm"
        
        return formatter.string(from: date)
    }
}

// MARK: Make constraints
private extension NotificationTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.scale),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.scale)
        ])
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 40.scale),
            iconView.heightAnchor.constraint(equalToConstant: 40.scale),
            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            iconView.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 68.scale),
            titleLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -8.scale),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            dateLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 18.scale)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 68.scale),
            descriptionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.scale),
            descriptionLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension NotificationTableCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 16.scale
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let view = UILabel()
        view.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeDateLabel() -> UILabel {
        let view = UILabel()
        view.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeDescriptionLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
