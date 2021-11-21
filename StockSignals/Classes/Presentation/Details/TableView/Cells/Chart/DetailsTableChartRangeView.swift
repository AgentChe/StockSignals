//
//  DetailsTableChartRangeView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 20.11.2021.
//

import UIKit

final class DetailsTableChartRangeView: UIView {
    enum Range {
        case oneDay, fiveDays, oneMonth, threeMonth, oneYear, fiveYears, max
    }
    
    lazy var range = Range.oneDay {
        didSet {
            update()
        }
    }
    
    lazy var oneDayButton = makeButton(title: "Details.Chart.1D".localized)
    lazy var fiveDayButton = makeButton(title: "Details.Chart.5D".localized)
    lazy var oneMonthButton = makeButton(title: "Details.Chart.1M".localized)
    lazy var threeMonthButton = makeButton(title: "Details.Chart.3M".localized)
    lazy var oneYearButton = makeButton(title: "Details.Chart.1Y".localized)
    lazy var fiveYearButton = makeButton(title: "Details.Chart.5Y".localized)
    lazy var maxButton = makeButton(title: "Details.Chart.MAX".localized)
    
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
private extension DetailsTableChartRangeView {
    func update() {
        let backColor1 = UIColor(integralRed: 62, green: 89, blue: 223)
        let backColor2 = UIColor.clear
        
        let textColor1 = UIColor.white
        let textColor2 = UIColor.white.withAlphaComponent(0.4)
        
        oneDayButton.backgroundColor = range == .oneDay ? backColor1 : backColor2
        oneDayButton.setTitleColor(range == .oneDay ? textColor1 : textColor2, for: .normal)
        
        fiveDayButton.backgroundColor = range == .fiveDays ? backColor1 : backColor2
        fiveDayButton.setTitleColor(range == .fiveDays ? textColor1 : textColor2, for: .normal)
        
        oneMonthButton.backgroundColor = range == .oneMonth ? backColor1 : backColor2
        oneMonthButton.setTitleColor(range == .oneMonth ? textColor1 : textColor2, for: .normal)
        
        threeMonthButton.backgroundColor = range == .threeMonth ? backColor1 : backColor2
        threeMonthButton.setTitleColor(range == .threeMonth ? textColor1 : textColor2, for: .normal)
        
        oneYearButton.backgroundColor = range == .oneYear ? backColor1 : backColor2
        oneYearButton.setTitleColor(range == .oneYear ? textColor1 : textColor2, for: .normal)
        
        fiveYearButton.backgroundColor = range == .fiveYears ? backColor1 : backColor2
        fiveYearButton.setTitleColor(range == .fiveYears ? textColor1 : textColor2, for: .normal)
        
        maxButton.backgroundColor = range == .max ? backColor1 : backColor2
        maxButton.setTitleColor(range == .max ? textColor1 : textColor2, for: .normal)
    }
}

// MARK: Make constraints
private extension DetailsTableChartRangeView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            oneDayButton.widthAnchor.constraint(equalToConstant: 41.scale),
            oneDayButton.heightAnchor.constraint(equalToConstant: 36.scale),
            oneDayButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            oneDayButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            fiveDayButton.widthAnchor.constraint(equalToConstant: 41.scale),
            fiveDayButton.heightAnchor.constraint(equalToConstant: 36.scale),
            fiveDayButton.leadingAnchor.constraint(equalTo: oneDayButton.trailingAnchor, constant: 8.scale),
            fiveDayButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            oneMonthButton.widthAnchor.constraint(equalToConstant: 41.scale),
            oneMonthButton.heightAnchor.constraint(equalToConstant: 36.scale),
            oneMonthButton.leadingAnchor.constraint(equalTo: fiveDayButton.trailingAnchor, constant: 8.scale),
            oneMonthButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            threeMonthButton.widthAnchor.constraint(equalToConstant: 41.scale),
            threeMonthButton.heightAnchor.constraint(equalToConstant: 36.scale),
            threeMonthButton.leadingAnchor.constraint(equalTo: oneMonthButton.trailingAnchor, constant: 8.scale),
            threeMonthButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            oneYearButton.widthAnchor.constraint(equalToConstant: 41.scale),
            oneYearButton.heightAnchor.constraint(equalToConstant: 36.scale),
            oneYearButton.leadingAnchor.constraint(equalTo: threeMonthButton.trailingAnchor, constant: 8.scale),
            oneYearButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            fiveYearButton.widthAnchor.constraint(equalToConstant: 41.scale),
            fiveYearButton.heightAnchor.constraint(equalToConstant: 36.scale),
            fiveYearButton.leadingAnchor.constraint(equalTo: oneYearButton.trailingAnchor, constant: 8.scale),
            fiveYearButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            maxButton.widthAnchor.constraint(equalToConstant: 41.scale),
            maxButton.heightAnchor.constraint(equalToConstant: 36.scale),
            maxButton.leadingAnchor.constraint(equalTo: fiveYearButton.trailingAnchor, constant: 8.scale),
            maxButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension DetailsTableChartRangeView {
    func makeButton(title: String) -> TapAreaButton {
        let view = TapAreaButton()
        view.dx = -4.scale
        view.setTitle(title, for: .normal)
        view.titleLabel?.font = Fonts.SFProDisplay.semiBold(size: 15.scale)
        view.layer.cornerRadius = 8.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
