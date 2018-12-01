//
//  Themes.swift
//  Sail
//
//  Created by Amy Harris on 01/12/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

struct ThemeModel: Codable {
    var currentThemeIndex: Int
    var currentTheme: Theme { return Theme.themes[currentThemeIndex] }
    
    enum Action {
        case setCurrent(Int)
    }
    
    static var reducer: (Action, ThemeModel) -> ThemeModel {
        return {action, state in
            var state = state
            
            switch action {
            case .setCurrent(let id):
                state.currentThemeIndex = id
            }
            
            return state
        }
    }
}
