//
//  WatchListSelectModeView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 22.10.2021.
//

import UIKit

final class WatchListSelectModeView: UIView {
    enum Mode {
        case signals, groups
    }
    
    lazy var mode = Mode.signals {
        didSet {
            update()
        }
    }
    
    lazy var signalsButton = makeSignalsButton()
    lazy var groupsButton = makeGroupsButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension WatchListSelectModeView {
    func update() {
        switch mode {
        case .signals:
            signalsButton.backgroundColor = UIColor(integralRed: 62, green: 89, blue: 223)
            groupsButton.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        case .groups:
            signalsButton.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
            groupsButton.backgroundColor = UIColor(integralRed: 62, green: 89, blue: 223)
        }
    }
}

// MARK: Make constraints
private extension WatchListSelectModeView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            signalsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            signalsButton.topAnchor.constraint(equalTo: topAnchor),
            signalsButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            groupsButton.leadingAnchor.constraint(equalTo: signalsButton.trailingAnchor, constant: 8.scale),
            groupsButton.topAnchor.constraint(equalTo: topAnchor),
            groupsButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension WatchListSelectModeView {
    func makeSignalsButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 15.scale))
        
        let view = UIButton()
        view.contentEdgeInsets = UIEdgeInsets(top: 8.scale, left: 12.scale, bottom: 8.scale, right: 12.scale)
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        view.layer.cornerRadius = 10.scale
        view.setAttributedTitle("WatchList.PopularProducts".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeGroupsButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 15.scale))
        
        let view = UIButton()
        view.contentEdgeInsets = UIEdgeInsets(top: 8.scale, left: 12.scale, bottom: 8.scale, right: 12.scale)
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        view.layer.cornerRadius = 10.scale
        view.setAttributedTitle("WatchList.MyWatchLists".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
