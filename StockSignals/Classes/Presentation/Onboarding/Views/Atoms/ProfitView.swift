//
//  ProfitView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 28.10.2021.
//

import UIKit

final class ProfitView: UIView {
    // 1, 2, 3, 4, 5, 10, 20
    var profit: Int = 1 {
        didSet {
            update()
        }
    }
    
    lazy var towersViews = makeTowersViews()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        update()
    }
}

// MARK: Private
private extension ProfitView {
    func update() {
        towersViews.forEach {
            $0.gradientLayer.colors = [
                UIColor(integralRed: 42, green: 46, blue: 57).cgColor,
                UIColor(integralRed: 42, green: 46, blue: 57).cgColor
            ]
        }
        
        var views = [GradientView]()
        
        switch profit {
        case 1:
            views = Array(towersViews.prefix(5))
        case 2:
            views = Array(towersViews.prefix(10))
        case 3:
            views = Array(towersViews.prefix(15))
        case 4:
            views = Array(towersViews.prefix(20))
        case 5:
            views = Array(towersViews.prefix(25))
        case 10:
            views = Array(towersViews.prefix(30))
        case 20:
            views = towersViews
        default:
            break
        }
        
        views.forEach {
            $0.gradientLayer.colors = [
                UIColor(integralRed: 112, green: 226, blue: 248).cgColor,
                UIColor(integralRed: 62, green: 89, blue: 223).cgColor
            ]
        }
    }
    
    func makeTowersViews() -> [GradientView] {
        var views = [GradientView]()
        
        var x = CGFloat(0)
        
        for _ in 1...37 {
            let view = GradientView()
            view.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            view.gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
            view.frame.size = CGSize(width: 3.scale, height: 26.scale)
            view.frame.origin = CGPoint(x: x, y: 0)
            views.append(view)
            
            addSubview(view)
            
            x += 3.scale + 6.scale
        }
        
        return views
    }
}
