//
//  UIFont + Custom fonts.swift
//  schedule
//
//  Created by Vladislav Glumov on 08.02.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

extension UIFont {
     enum FontWeight: String {
        /// weight is 100
        case ultralight = "Ultralight"
        
        /// weight is 200
        case thin = "Thin"
        
        /// weight is 300
        case light = "Light"
        
        /// weight is 400
        case regular = "Regular"
        
        /// weight is 500
        case medium = "Medium"
        
        /// weight is 600
        case semibold = "Semibold"
        
        /// weight is 700
        case bold = "Bold"
        
        /// weight is 800
        case heavy = "Heavy"
        
        /// weight is 900
        case black = "Black"
    }
}

extension UIFont {
    class func SFProDisplay(size: CGFloat, weight: FontWeight = .regular) -> UIFont {
        return UIFont(name: "SFProDisplay-\(weight.rawValue)", size: size)!
    }
    
    class func SFProText(size: CGFloat, weight: FontWeight = .regular) -> UIFont {
        return UIFont(name: "SFProText-\(weight.rawValue)", size: size)!
    }
}
