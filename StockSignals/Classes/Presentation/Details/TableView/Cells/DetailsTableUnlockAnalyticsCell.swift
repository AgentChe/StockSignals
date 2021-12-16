//
//  DetailsTableUnlockAnalyticsCell.swift
//  StockSignals
//
//  Created by Андрей Чернышев on 15.12.2021.
//

import UIKit

final class DetailsTableUnlockAnalyticsCell: UITableViewCell {
    weak var mainDelegate: DetailsTableViewDelegate?
    
    lazy var container = makeContainer()
    lazy var circleView = makeCircleView()
    lazy var label = makeLabel()
    lazy var lockView = makeLockView()
    lazy var button = makeButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension DetailsTableUnlockAnalyticsCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    @objc
    func tapped() {
        mainDelegate?.detailsTableViewDidTappedUnlockAnalytics()
    }
}

// MARK: Make constraints
private extension DetailsTableUnlockAnalyticsCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.heightAnchor.constraint(equalToConstant: 92.scale)
        ])
        
        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: 60.scale),
            circleView.heightAnchor.constraint(equalToConstant: 60.scale),
            circleView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            circleView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 88.scale),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            lockView.widthAnchor.constraint(equalToConstant: 16.scale),
            lockView.heightAnchor.constraint(equalToConstant: 20.scale),
            lockView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            lockView.topAnchor.constraint(equalTo: container.topAnchor, constant: 14.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 207.scale),
            button.heightAnchor.constraint(equalToConstant: 55.scale),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension DetailsTableUnlockAnalyticsCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        view.layer.cornerRadius = 16.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeCircleView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Details.Analytics.Unlock.Circle")
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
            .lineHeight(22.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Details.Analytics.Unlock.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeLockView() -> UIImageView {
        let view = UIImageView()
        view.alpha = 0.2
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Details.Analytics.Unlock.Lock")
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
        
        let view = UIButton()
        view.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        view.layer.cornerRadius = 16.scale
        view.backgroundColor = UIColor(integralRed: 238, green: 142, blue: 72)
        view.setAttributedTitle("Details.Analytics.Unlock.Button".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
