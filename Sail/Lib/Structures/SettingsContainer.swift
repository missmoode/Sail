//
//  ThemeSettings.swift
//  Sail
//
//  Created by Amy Harris on 05/01/2019.
//  Copyright © 2019 Amelia Harris. All rights reserved.
//

import Foundation

struct SettingsContainer: Codable {
    var currentThemeIndex: Int = 0
    var currentTheme: Theme { return Theme.themes[currentThemeIndex] }
    
}
