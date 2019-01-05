//
//  Tag.swift
//  Sail
//
//  Created by Amy Harris on 05/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

struct MTag: Codable {
    let name: String
    let url: URL
    let history: [MHistory]?
}
