//
//  WatchListView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 21.10.2021.
//

import UIKit

final class WatchListView: UIView {
    lazy var titleLabel = makeTitleLabel()
    lazy var modeView = makeModeView()
    lazy var signalsView = makeSignalsView()
    lazy var groupsView = makeGroupsView()
    lazy var createGroupView = makeCreateGroupView()
    
    private lazy var signalsLeadingConstraint = NSLayoutConstraint()
    private lazy var groupsLeadingConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension WatchListView {
    func updateVisible() {
        NSLayoutConstraint.deactivate([
            signalsLeadingConstraint, groupsLeadingConstraint
        ])
        
        switch modeView.mode {
        case .signals:
            signalsLeadingConstraint = signalsView.leadingAnchor.constraint(equalTo: leadingAnchor)
            groupsLeadingConstraint = groupsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 375.scale)
        case .groups:
            signalsLeadingConstraint = signalsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -375.scale)
            groupsLeadingConstraint = groupsView.leadingAnchor.constraint(equalTo: leadingAnchor)
        }
        
        NSLayoutConstraint.activate([
            signalsLeadingConstraint, groupsLeadingConstraint
        ])
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.layoutIfNeeded()
        })
    }
}

// MARK: Private
private extension WatchListView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
    }
}

// MARK: Make constraints
private extension WatchListView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 92.scale : 32.scale)
        ])
        
        NSLayoutConstraint.activate([
            modeView.leadingAnchor.constraint(equalTo: leadingAnchor),
            modeView.trailingAnchor.constraint(equalTo: trailingAnchor),
            modeView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.scale),
            modeView.heightAnchor.constraint(equalToConstant: 34.scale)
        ])
        
        signalsLeadingConstraint = signalsView.leadingAnchor.constraint(equalTo: leadingAnchor)
        NSLayoutConstraint.activate([
            signalsLeadingConstraint,
            signalsView.widthAnchor.constraint(equalToConstant: 375.scale),
            signalsView.topAnchor.constraint(equalTo: modeView.bottomAnchor, constant: 24.scale),
            signalsView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        groupsLeadingConstraint = groupsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 375.scale)
        NSLayoutConstraint.activate([
            groupsLeadingConstraint,
            groupsView.widthAnchor.constraint(equalToConstant: 375.scale),
            groupsView.topAnchor.constraint(equalTo: modeView.bottomAnchor, constant: 24.scale),
            groupsView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            createGroupView.leadingAnchor.constraint(equalTo: leadingAnchor),
            createGroupView.trailingAnchor.constraint(equalTo: trailingAnchor),
            createGroupView.topAnchor.constraint(equalTo: topAnchor),
            createGroupView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension WatchListView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 34.scale))
            .lineHeight(41.scale)
        
        let view = UILabel()
        view.attributedText = "WatchList.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeModeView() -> WatchListSelectModeView {
        let view = WatchListSelectModeView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSignalsView() -> WatchListSignalsView {
        let view = WatchListSignalsView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeGroupsView() -> WatchListGroupsView {
        let view = WatchListGroupsView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCreateGroupView() -> CreateWatchListGroupView {
        let view = CreateWatchListGroupView()
        view.dismiss()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
