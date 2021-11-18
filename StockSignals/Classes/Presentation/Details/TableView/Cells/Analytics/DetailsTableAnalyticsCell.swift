//
//  DetailsTableAnalyticsCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 17.11.2021.
//

import UIKit

final class DetailsTableAnalyticsCell: UITableViewCell {
    lazy var ratingView = makeRatingView()
    lazy var container = makeContainer()
    lazy var titleLabel = makeLabel()
    lazy var noteLabel = makeLabel()
    
    private lazy var titleLabelBottomConstraint = NSLayoutConstraint()
    private lazy var noteLabelBottomConstraint = NSLayoutConstraint()
    private lazy var noteLabelLeadingConstraint = NSLayoutConstraint()
    private lazy var noteLabelTrailingConstraint = NSLayoutConstraint()
    
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
extension DetailsTableAnalyticsCell {
    func setup(element: DetailsAnalytics) {
//        ratingView.needleValue = 50
        
        titleLabel.attributedText = title(at: element)?
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 235, green: 96, blue: 42))
                            .font(Fonts.SFProDisplay.bold(size: 19.scale))
                            .lineHeight(22.8.scale)
                            .textAlignment(.center))
        
        noteLabel.attributedText = element.description?
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.regular(size: 17.scale))
                            .lineHeight(23.8.scale)
                            .textAlignment(.center))
        
        updateConstraints(noteNil: element.description == nil)
    }
}

// MARK: Private
private extension DetailsTableAnalyticsCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    func title(at: DetailsAnalytics) -> String? {
        let value = Int(round(at.averageRating))
        
        let possible = at.possibleRatings.first(where: { $0.value == value })
        
        return possible?.title
    }
    
    func updateConstraints(noteNil: Bool) {
        NSLayoutConstraint.deactivate([
            titleLabelBottomConstraint,
            noteLabelBottomConstraint,
            noteLabelLeadingConstraint,
            noteLabelTrailingConstraint
        ])
        
        switch noteNil {
        case true:
            titleLabelBottomConstraint = titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12.scale)
            
            titleLabelBottomConstraint.isActive = true
        case false:
            titleLabelBottomConstraint = titleLabel.bottomAnchor.constraint(equalTo: noteLabel.topAnchor, constant: -12.scale)
            noteLabelBottomConstraint = noteLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12.scale)
            noteLabelLeadingConstraint = noteLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale)
            noteLabelTrailingConstraint = noteLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale)
            
            NSLayoutConstraint.activate([
                titleLabelBottomConstraint,
                noteLabelBottomConstraint,
                noteLabelLeadingConstraint,
                noteLabelTrailingConstraint
            ])
        }
        
        layoutIfNeeded()
    }
}

// MARK: Make constraints
private extension DetailsTableAnalyticsCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            ratingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ratingView.widthAnchor.constraint(equalToConstant: 191.scale),
            ratingView.heightAnchor.constraint(equalToConstant: 191.scale),
            ratingView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 16.scale),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        titleLabelBottomConstraint = titleLabel.bottomAnchor.constraint(equalTo: noteLabel.topAnchor, constant: -12.scale)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 12.scale),
            titleLabelBottomConstraint
        ])
        
        noteLabelBottomConstraint = noteLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12.scale)
        noteLabelLeadingConstraint = noteLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale)
        noteLabelTrailingConstraint = noteLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale)
        NSLayoutConstraint.activate([
            noteLabelBottomConstraint,
            noteLabelLeadingConstraint,
            noteLabelTrailingConstraint
        ])
    }
}

// MARK: Lazy initialization
private extension DetailsTableAnalyticsCell {
    func makeRatingView() -> DetailsTableAnalyticsGaugeView {
        let view = DetailsTableAnalyticsGaugeView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 20.scale
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
