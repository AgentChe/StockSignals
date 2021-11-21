//
//  DetailsTableChartView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 20.11.2021.
//

import UIKit

final class DetailsTableChartView: UIView {
    var chart: Chart? = nil {
        didSet {
            
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
private extension DetailsTableChartView {
    
}

// MARK: Make constraints
private extension DetailsTableChartView {
    func makeConstraints() {
        
    }
}

// MARK: Lazy initialization
private extension DetailsTableChartView {
    
}
