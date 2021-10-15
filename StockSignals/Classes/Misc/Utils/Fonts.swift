//
//  Fonts.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 16.01.2021.
//

import UIKit

struct Fonts {
    // MARK: SFProDisplay
    struct SFProDisplay {
        static func bold(size: CGFloat) -> UIFont {
            UIFont(name: "SFProDisplay-Bold", size: size)!
        }
        
        static func regular(size: CGFloat) -> UIFont {
            UIFont(name: "SFProDisplay-Regular", size: size)!
        }
        
        static func semiBold(size: CGFloat) -> UIFont {
            UIFont(name: "SFProDisplay-Semibold", size: size)!
        }
    }
}
