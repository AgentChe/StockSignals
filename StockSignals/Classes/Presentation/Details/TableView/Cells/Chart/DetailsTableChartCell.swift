//
//  DetailsTableChartCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 20.11.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailsTableChartCell: UITableViewCell {
    lazy var chartView = makeChartView()
    lazy var rangeView = makeRangeView()
    
    private lazy var range = BehaviorRelay<DetailsTableChartRangeView.Range>(value: .oneDay)
    
    private lazy var signalsManager = SignalManagerCore()
    
    private lazy var disposeBag = DisposeBag()
    
    private let symbol: String
    
    init(symbol: String) {
        self.symbol = symbol
        
        super.init(style: .default, reuseIdentifier: nil)
        
        makeConstraints()
        initialize()
        addRangeActions()
        addLoadChartAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension DetailsTableChartCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    func addRangeActions() {
        Observable
            .merge(
                rangeView.oneDayButton.rx.tap.map { DetailsTableChartRangeView.Range.oneDay },
                rangeView.fiveDayButton.rx.tap.map { DetailsTableChartRangeView.Range.fiveDays },
                rangeView.oneMonthButton.rx.tap.map { DetailsTableChartRangeView.Range.oneMonth },
                rangeView.threeMonthButton.rx.tap.map { DetailsTableChartRangeView.Range.threeMonth },
                rangeView.oneYearButton.rx.tap.map { DetailsTableChartRangeView.Range.oneYear },
                rangeView.fiveYearButton.rx.tap.map { DetailsTableChartRangeView.Range.fiveYears },
                rangeView.maxButton.rx.tap.map { DetailsTableChartRangeView.Range.max }
            )
            .subscribe(onNext: { [weak self] range in
                self?.rangeView.range = range
                self?.range.accept(range)
            })
            .disposed(by: disposeBag)
    }
    
    func addLoadChartAction() {
        range.flatMapLatest { [weak self] range -> Single<Chart?> in
            guard let self = self else {
                return .never()
            }
            
            let string = self.rangeToString(range)
            
            return self.signalsManager
                .obtainChart(by: self.symbol, range: string)
                .catchAndReturn(nil)
        }
        .asDriver(onErrorJustReturn: nil)
        .drive(onNext: { [weak self] chart in
            self?.chartView.chart = chart
        })
        .disposed(by: disposeBag)
    }
    
    func rangeToString(_ range: DetailsTableChartRangeView.Range) -> String {
        switch range {
        case .oneDay:
            return "1d"
        case .fiveDays:
            return "5d"
        case .oneMonth:
            return "1M"
        case .threeMonth:
            return "3M"
        case .oneYear:
            return "1Y"
        case .fiveYears:
            return "5Y"
        case .max:
            return "max"
        }
    }
}

// MARK: Make constraints
private extension DetailsTableChartCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            chartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            chartView.topAnchor.constraint(equalTo: contentView.topAnchor),
            chartView.heightAnchor.constraint(equalToConstant: 233.scale)
        ])
        
        NSLayoutConstraint.activate([
            rangeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            rangeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            rangeView.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 16.scale),
            rangeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            rangeView.heightAnchor.constraint(equalToConstant: 44.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension DetailsTableChartCell {
    func makeChartView() -> DetailsTableChartView {
        let view = DetailsTableChartView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeRangeView() -> DetailsTableChartRangeView {
        let view = DetailsTableChartRangeView()
        view.backgroundColor = UIColor(integralRed: 118, green: 118, blue: 128, alpha: 0.24)
        view.layer.cornerRadius = 12.scale
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
