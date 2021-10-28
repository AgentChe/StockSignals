//
//  RateView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 28.10.2021.
//

import UIKit

final class RateView: UIView {
    lazy var largeCircle: RateCircleView = {
        let view = RateCircleView()
        view.frame.size = CGSize(width: ScreenSize.isIphoneXFamily ? 161.scale : 131.scale,
                                 height: ScreenSize.isIphoneXFamily ? 161.scale : 131.scale)
        view.frame.origin = CGPoint(x: 107.scale, y: 0)
        view.pieFilledColor = UIColor(integralRed: 235, green: 96, blue: 42, alpha: 0.9)
        view.pieBackgroundColor = UIColor(integralRed: 129, green: 232, blue: 129, alpha: 0.9)
        view.backgroundColor = UIColor.clear
        addSubview(view)
        return view
    }()
    
    lazy var smallCircle: RateCircleView = {
        let view = RateCircleView()
        view.frame.size = CGSize(width: ScreenSize.isIphoneXFamily ? 119.scale : 89.scale,
                                 height: ScreenSize.isIphoneXFamily ? 119.scale : 89.scale)
        view.frame.origin = CGPoint(x: 128.scale, y: 21.scale)
        view.pieFilledColor = UIColor(integralRed: 235, green: 96, blue: 42)
        view.pieBackgroundColor = UIColor(integralRed: 129, green: 232, blue: 129)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 8.scale
        view.backgroundColor = UIColor.clear
        addSubview(view)
        return view
    }()
    
    lazy var winRateLabel: UILabel = {
        let view = UILabel()
        view.frame.origin = CGPoint(x: 28.scale, y: 23.scale)
        view.layer.cornerRadius = 8.scale
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        addSubview(view)
        return view
    }()
    
    lazy var loseRateLabel: UILabel = {
        let view = UILabel()
        view.frame.origin = CGPoint(x: 196.scale, y: 105.scale)
        view.layer.cornerRadius = 8.scale
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        addSubview(view)
        return view
    }()
    
    // 1, 2, 3, 4, 5, 10, 20
    func setup(value: Int) {
        largeCircle.value = value
        smallCircle.value = value
        
        let transformedValue = transformToString(value: value)
        
        let attrs = TextAttributes()
            .font(Fonts.SFProDisplay.bold(size: 17.scale))
            .textColor(UIColor.white)
            .textAlignment(.center)
        
        let winRateAttrs = String(format: "Onboarding.Profit.WinRate".localized, transformedValue.win).attributed(with: attrs)
        winRateLabel.attributedText = winRateAttrs
        var winRateSize = winRateAttrs.size()
        winRateSize.width += 24.scale
        winRateSize.height += 20.scale
        winRateLabel.frame.size = winRateSize
        
        let loseRateAttrs = String(format: "Onboarding.Profit.LoseRate".localized, transformedValue.lose).attributed(with: attrs)
        loseRateLabel.attributedText = loseRateAttrs
        var loseRateSize = loseRateAttrs.size()
        loseRateSize.width += 24.scale
        loseRateSize.height += 20.scale
        loseRateLabel.frame.size = loseRateSize
    }
}

// MARK: Private
private extension RateView {
    func transformToString(value: Int) -> (win: String, lose: String) {
        switch value {
        case 1:
            return ("50.00", "50.00")
        case 2:
            return ("33.33", "66.67")
        case 3:
            return ("25.00", "75.00")
        case 4:
            return ("20.00", "80.00")
        case 5:
            return ("16.67", "83.33")
        case 10:
            return ("9.09", "90.91")
        case 20:
            return ("4.76", "95.24")
        default:
            return ("", "")
        }
    }
}
