//
//  AllSignalsSortButton.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 04.11.2021.
//

import UIKit

final class AllSignalsSortButton: UIButton {
    lazy var sort: AllSignalsSort = .maxGain {
        didSet {
            update()
        }
    }
    
    lazy var label = makeLabel()
    lazy var iconView = makeIconView()
    
    private lazy var labelTrailingConstraint = NSLayoutConstraint()
    
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
private extension AllSignalsSortButton {
    func update() {
        labelTrailingConstraint.isActive = false
        
        let hiddenIcon = sort == .maxGain || sort == .name
        
        labelTrailingConstraint = label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: hiddenIcon ? -12.scale : -40.scale)
        
        labelTrailingConstraint.isActive = true
        
        iconView.isHidden = hiddenIcon
        
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 15.scale))
            .lineHeight(18.scale)
        
        let sortString: String
        switch sort {
        case .createdDown:
            sortString = "Signals.Sort.OpenDate".localized
            
            iconView.image = UIImage(named: "Signals.ArrowDown")
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = UIColor(integralRed: 62, green: 89, blue: 223)
        case .createdUp:
            sortString = "Signals.Sort.OpenDate".localized
            
            iconView.image = UIImage(named: "Signals.ArrowUp")
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = UIColor(integralRed: 62, green: 89, blue: 223)
        case .maxGain:
            sortString = "Signals.Sort.MaxGain".localized
        case .name:
            sortString = "Signals.Sort.Name".localized
        }
        let string = String(format: "%@ %@", "Signals.Sort.SortBy".localized, sortString)
        label.attributedText = string.attributed(with: attrs)
    }
}

// MARK: Make constraints
private extension AllSignalsSortButton {
    func makeConstraints() {
        labelTrailingConstraint = label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40.scale)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.scale),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 11.scale),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11.scale),
            labelTrailingConstraint
        ])
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 24.scale),
            iconView.heightAnchor.constraint(equalToConstant: 24.scale),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension AllSignalsSortButton {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
