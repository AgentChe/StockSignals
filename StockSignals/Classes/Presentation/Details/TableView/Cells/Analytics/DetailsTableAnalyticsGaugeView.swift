//
//  GaugeView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 17.11.2021.
//

import UIKit

final class DetailsTableAnalyticsGaugeView: UIView {
    var needleValue = Double(0) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private lazy var gradientLayer = makeGradientLayer()
    private lazy var arcLayer = CAShapeLayer()
    private lazy var largeDiscLayer = CAShapeLayer()
    private lazy var triangleLayer = CAShapeLayer()
    private lazy var smallDiscLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        triangleLayer.removeAllAnimations()
        triangleLayer.removeFromSuperlayer()
        largeDiscLayer.removeFromSuperlayer()
        smallDiscLayer.removeFromSuperlayer()
        
        drawArc(in: rect)
        drawLargeDisc(in: rect)
        drawCursor(in: rect)
        drawSmallDisc(in: rect)
    }
}

// MARK: Private
private extension DetailsTableAnalyticsGaugeView {
    func drawArc(in rect: CGRect) {
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
    
    func drawLargeDisc(in rect: CGRect) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: rect.origin.x + rect.size.width / 2,
                                                         y: rect.origin.y + rect.size.height / 2),
                                      radius: 20.scale,
                                      startAngle: 0,
                                      endAngle: .pi * 2,
                                      clockwise: true)
        
        largeDiscLayer = CAShapeLayer()
            
        largeDiscLayer.path = circlePath.cgPath
        largeDiscLayer.fillColor = UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7).cgColor
        largeDiscLayer.strokeColor = UIColor.clear.cgColor
        largeDiscLayer.lineWidth = 1.scale
        
        layer.addSublayer(largeDiscLayer)
    }
    
    func drawCursor(in rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.width / 2, y: rect.height * 0.95))
        path.addLine(to: CGPoint(x: rect.width * 0.47, y: rect.height * 0.47))
        path.addLine(to: CGPoint(x: rect.width * 0.53, y: rect.height * 0.47))
        path.close()
        
        triangleLayer = CAShapeLayer()
        
        triangleLayer.frame = rect
        triangleLayer.path = path.cgPath
        triangleLayer.fillColor = UIColor(integralRed: 50, green: 54, blue: 66, alpha: 0.7).cgColor
        triangleLayer.strokeColor = UIColor(integralRed: 50, green: 54, blue: 66, alpha: 0.7).cgColor
        
        layer.addSublayer(triangleLayer)
        
        var firstAngle = deg2rad(0)

        let degrees:CGFloat = 3.6 * 100
        let radians = degrees * .pi/(1.8*100)

        let thisRadians: CGFloat = (2.4 * 100) * .pi/(1.8*100)
        let theD = (radians - thisRadians)/2
        firstAngle += theD
        let needleValue = deg2rad(2.4 * CGFloat(self.needleValue)) + firstAngle

        triangleLayer.transform = CATransform3DMakeRotation(needleValue, 0, 0, 1)
    }
    
    func drawSmallDisc(in rect: CGRect) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: rect.origin.x + rect.size.width / 2,
                                                         y: rect.origin.y + rect.size.height / 2),
                                      radius: 4.scale,
                                      startAngle: 0,
                                      endAngle: .pi * 2,
                                      clockwise: true)
            
        smallDiscLayer = CAShapeLayer()
        
        smallDiscLayer.path = circlePath.cgPath
        smallDiscLayer.fillColor = UIColor(integralRed: 37, green: 40, blue: 51).cgColor
        smallDiscLayer.strokeColor = UIColor.clear.cgColor
        smallDiscLayer.lineWidth = 1.scale
        
        layer.addSublayer(smallDiscLayer)
    }
    
    func deg2rad(_ number: CGFloat) -> CGFloat {
        number * .pi / 180
    }
}

// MARK: Lazy initialization
private extension DetailsTableAnalyticsGaugeView {
    func makeGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        layer.addSublayer(gradientLayer)
        return gradientLayer
    }
}
