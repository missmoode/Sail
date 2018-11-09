//
//  Closures.swift
//  Sail
//
//  Created by Amy Harris on 02/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import Localize_Swift

extension Error {
    public var localizedDescription: String {
        return ("error:" + String(describing: type(of: self)) + "_" + String(describing: self)).localized()
    }
}
