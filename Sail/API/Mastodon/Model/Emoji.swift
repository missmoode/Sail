//
//  Emoji.swift
//  Sail
//
//  Created by Amy Harris on 05/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

struct MEmoji: Codable {
    let shortcode: String
    let staticUrl: URL
    let url: URL
    let visibleInPicker: Bool
}
