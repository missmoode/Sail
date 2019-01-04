//
//  SetupViewController.swift
//  Sail
//
//  Created by Amy Harris on 03/01/2019.
//  Copyright © 2019 Amelia Harris. All rights reserved.
//

import Foundation
import UIKit

class BackgroundView: UIView {
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = [
            UIColor(red: 0x8C, green: 0x44, blue: 0xC1).cgColor,
            UIColor(red: 0x69, green: 0x2F, blue: 0x8E).cgColor
        ]
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: [0, 1])!
        
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: rect.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
    }
}
