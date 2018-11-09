//
//  StatusVisibility.swift
//  Sail
//
//  Created by Amy Harris on 05/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

enum MStatusVisibility: String, Codable {
    case modePublic = "public"
    case modeUnlisted = "unlisted"
    case modePrivate = "private"
    case modeDirect = "direct"
}
