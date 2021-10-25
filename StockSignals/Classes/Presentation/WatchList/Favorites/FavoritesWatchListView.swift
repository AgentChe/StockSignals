//
//  FavoritesWatchListView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 25.10.2021.
//

import UIKit

final class FavoritesWatchListView: UIView {
    lazy var titleLabel = makeTitleLabel()
    lazy var titlesView = makeTitlesView()
    lazy var tableView = makeTableView()
    
    private let group: WatchListGroup
    
    init(group: WatchListGroup) {
        self.group = group
        
        super.init(frame: .zero)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension FavoritesWatchListView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
    }
}

// MARK: Make constraints
private extension FavoritesWatchListView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32.scale)
        ])
        
        NSLayoutConstraint.activate([
            titlesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titlesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titlesView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.scale),
            titlesView.heightAnchor.constraint(equalToConstant: 37.scale)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: titlesView.bottomAnchor, constant: 32.scale),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension FavoritesWatchListView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 34.scale))
            .lineHeight(41.scale)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = group.name.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitlesView() -> WatchListSignalsTitlesView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 90.scale, height: 37.scale)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 32.scale
        layout.headerReferenceSize = CGSize(width: 160.scale, height: 37.scale)
        layout.sectionHeadersPinToVisibleBounds = true
        
        let view = WatchListSignalsTitlesView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTableView() -> WatchListSignalsTableView {
        let view = WatchListSignalsTableView()
        view.backgroundColor = UIColor.clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
