//
//  PaygateView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.12.2021.
//

import UIKit

final class PaygateView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension PaygateView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
    }
}

// MARK: Make constraints
private extension PaygateView {
    func makeConstraints() {
        
    }
}

// MARK: Lazy initialization
private extension PaygateView {
    
}
