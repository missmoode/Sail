//
//  Weak.swift
//  Sail
//
//  Created by Amy Harris on 31/12/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

struct Weak<Object: AnyObject> {
    weak var value: Object?
}
