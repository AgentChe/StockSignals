//
//  GaugeView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 17.11.2021.
//

import UIKit

final class DetailsTableAnalyticsGaugeView: UIView {
    var needleValue = 1 {
        didSet {
            
        }
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        layer.addSublayer(gradientLayer)
        return gradientLayer
    }()
    
    private lazy var arcLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        drawArc(in: rect, context: ctx)
        drawDisc(in: rect, context: ctx)
        drawCursor(in: rect, context: ctx)
    }
}

// MARK: Private
private extension DetailsTableAnalyticsGaugeView {
    func drawArc(in rect: CGRect, context ctx: CGContext) {
        gradientLayer.frame = rect
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = [
            UIColor(integralRed: 255, green: 0, blue: 0).cgColor,
            UIColor(integralRed: 238, green: 142, blue: 72).cgColor,
            UIColor(integralRed: 235, green: 238, blue: 72).cgColor,
            UIColor(integralRed: 255, green: 255, blue: 255).cgColor,
            UIColor(integralRed: 129, green: 232, blue: 129).cgColor
        ]
        
        let radius = (rect.width - 24.scale) / 2
        
        let path = UIBezierPath()
        path.lineCapStyle = .round
        path.addArc(withCenter: CGPoint(x: rect.width / 2, y: rect.height / 2),
                    radius: radius,
                    startAngle: deg2rad(-220),
                    endAngle: deg2rad(40),
                    clockwise: true)
        
        arcLayer.lineWidth = 24.scale
        arcLayer.strokeColor = UIColor.white.cgColor
        arcLayer.fillColor = UIColor.clear.cgColor
        arcLayer.path = path.cgPath
        arcLayer.lineCap = .round
        
        gradientLayer.mask = arcLayer
    }
    
    func drawDisc(in rect: CGRect, context ctx: CGContext) {
        ctx.saveGState()
        ctx.translateBy(x: rect.midX, y: rect.midY)

        let outerCenterRect = CGRect(x: -39.scale / 2, y: -39.scale / 2, width: 39.scale, height: 39.scale)
        UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7).set()
        ctx.fillEllipse(in: outerCenterRect)

        ctx.restoreGState()
    }
    
    func drawCursor(in rect: CGRect, context ctx: CGContext) {
        
    }
    
    func deg2rad(_ number: CGFloat) -> CGFloat {
        number * .pi / 180
    }
}
