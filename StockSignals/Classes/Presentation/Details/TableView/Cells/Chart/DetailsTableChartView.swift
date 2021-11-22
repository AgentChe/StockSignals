//
//  DetailsTableChartView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 20.11.2021.
//

import UIKit
import Charts

final class DetailsTableChartView: UIView {
    var chart: Chart? = nil {
        didSet {
            reset()
            drawChart()
        }
    }
    
    lazy var chartView = makeChartView()
    
    private lazy var gradient = makeGradient()
    private lazy var fillFormatter = makeFillFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension DetailsTableChartView {
    func reset() {
        chartView.data = nil
    }
    
    func drawChart() {
        guard let chart = chart else {
            return
        }
        
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0 ..< chart.timestamp.count {
            let value = ChartDataEntry(x: chart.timestamp[i],
                                       y: chart.high[i])
            
            lineChartEntry.append(value)
        }
        
        let line = LineChartDataSet(entries: lineChartEntry)
        line.axisDependency = .left
        line.setColor(UIColor(integralRed: 129, green: 232, blue: 129))
        line.drawCirclesEnabled = false
        line.lineWidth = 1.scale
        line.fillAlpha = 1
        line.drawFilledEnabled = true
        line.drawCircleHoleEnabled = false
        line.fillFormatter = fillFormatter
        
        if let gradient = gradient {
            line.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        }
        
        let data = LineChartData()
        data.addDataSet(line)
        
        chartView.data = data
    }
}

// MARK: Make constraints
private extension DetailsTableChartView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            chartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: trailingAnchor),
            chartView.topAnchor.constraint(equalTo: topAnchor),
            chartView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension DetailsTableChartView {
    func makeChartView() -> LineChartView {
        let view = LineChartView()
        view.backgroundColor = UIColor.clear
        view.xAxis.enabled = false
        view.rightAxis.enabled = false
        view.leftAxis.enabled = false
        view.legend.enabled = false
        view.pinchZoomEnabled = false
        view.dragEnabled = false
        view.setScaleEnabled(false)
        view.chartDescription?.enabled = false
        view.drawGridBackgroundEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeGradient() -> CGGradient? {
        let gradientColors = [
            UIColor(integralRed: 20, green: 255, blue: 0, alpha: 0.32).cgColor,
            UIColor(integralRed: 216, green: 216, blue: 216, alpha: 0.16).cgColor,
            UIColor(integralRed: 24, green: 26, blue: 36, alpha: 0).cgColor
        ] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                  colors: gradientColors,
                                  locations: colorLocations)

        return gradient
    }
    
    func makeFillFormatter() -> DefaultFillFormatter {
        DefaultFillFormatter { [weak self] _, _ -> CGFloat in
            guard let self = self else {
                return 0
            }

            return CGFloat(self.chartView.leftAxis.axisMinimum)
        }
    }
}
