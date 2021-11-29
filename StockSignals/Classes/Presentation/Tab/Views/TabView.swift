//
//  TabView.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 17.01.2021.
//

import UIKit

final class TabView: UIView {
    enum Tab {
        case signals, notifications, market, watchList
    }
    
    lazy var signalsItem = makeItem(image: "Tab.Signals", title: "Tab.Signals")
    lazy var notificationsItem = makeItem(image: "Tab.Notifications", title: "Tab.Notifications")
    lazy var marketItem = makeItem(image: "Tab.Market", title: "Tab.Market")
    lazy var watchListItem = makeItem(image: "Tab.WatchList", title: "Tab.WatchList")
    
    var selectedTab = Tab.signals {
        didSet {
            update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension TabView {
    func update() {
        [
            signalsItem,
            notificationsItem,
            marketItem,
            watchListItem
        ]
        .forEach {
            $0.state = .deselected
        }
        
        switch selectedTab {
        case .signals:
            signalsItem.state = .selected
        case .notifications:
            notificationsItem.state = .selected
        case .market:
            marketItem.state = .selected
        case .watchList:
            watchListItem.state = .selected
        }
    }
}

// MARK: Make constraints
private extension TabView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            signalsItem.leadingAnchor.constraint(equalTo: leadingAnchor),
            signalsItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            signalsItem.topAnchor.constraint(equalTo: topAnchor),
            signalsItem.widthAnchor.constraint(equalTo: notificationsItem.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            notificationsItem.leadingAnchor.constraint(equalTo: signalsItem.trailingAnchor),
            notificationsItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            notificationsItem.topAnchor.constraint(equalTo: topAnchor),
            notificationsItem.widthAnchor.constraint(equalTo: marketItem.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            marketItem.leadingAnchor.constraint(equalTo: notificationsItem.trailingAnchor),
            marketItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            marketItem.topAnchor.constraint(equalTo: topAnchor),
            marketItem.widthAnchor.constraint(equalTo: watchListItem.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            watchListItem.leadingAnchor.constraint(equalTo: marketItem.trailingAnchor),
            watchListItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            watchListItem.topAnchor.constraint(equalTo: topAnchor),
            watchListItem.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension TabView {
    func makeItem(image: String, title: String) -> TabItemView {
        let attrs = TextAttributes()
            .font(Fonts.SFProDisplay.semiBold(size: 13.scale))
            .textColor(UIColor.white.withAlphaComponent(0.4))
            .textAlignment(.center)
        
        let view = TabItemView()
        view.backgroundColor = UIColor.clear
        view.imageView.image = UIImage(named: image)
        view.label.attributedText = title.localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
