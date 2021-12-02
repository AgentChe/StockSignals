//
//  CreateScreenerView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.12.2021.
//

import UIKit

final class CreateScreenerView: UIView {
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
private extension CreateScreenerView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
    }
}

// MARK: Make constraints
private extension CreateScreenerView {
    func makeConstraints() {
        
    }
}

// MARK: Lazy initialization
private extension CreateScreenerView {
    
}
