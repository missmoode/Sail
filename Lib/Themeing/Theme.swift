//
//  Themed.swift
//  Sail
//
//  Created by Amy Harris on 08/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

struct Theme {
    var statusBarStyle: UIStatusBarStyle
    var primaryTintBackgroundColor: UIColor
    var primaryTintForegroundColor: UIColor
}

extension Theme {
    static let light = Theme(
        statusBarStyle: .default,
        primaryTintBackgroundColor: UIColor(rgb: 0x5EC9B6),
        primaryTintForegroundColor: UIColor.white
    )
    
    static let dark = Theme(
        statusBarStyle: .lightContent,
        primaryTintBackgroundColor: UIColor(rgb: 242424),
        primaryTintForegroundColor: UIColor.white
    )
}
