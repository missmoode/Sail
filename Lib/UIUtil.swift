//
//  UIUtil.swift
//  Sail
//
//  Created by Amy Harris on 04/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func makeRounded() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.masksToBounds = true
    }
}
