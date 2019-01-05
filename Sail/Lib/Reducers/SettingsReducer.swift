//
//  Themes.swift
//  Sail
//
//  Created by Amy Harris on 01/12/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

let SettingStoreReducer: (Any, SettingsContainer) -> SettingsContainer = {update, state in
    var state = state
    
    
    if let update = update as? SettingsUpdate {
        switch update {
        case .setThemeID(let id):
            state.currentThemeIndex = id
            break
        }
    }
    
    return state
}
