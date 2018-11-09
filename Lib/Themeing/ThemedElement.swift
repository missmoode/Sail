//
//  ThemedElement.swift
//  Sail
//
//  Created by Amy Harris on 08/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import UIKit

class ThemeProvider {
    static let shared = .init()
    
    private init() {
        
    }
    
    var currentTheme: Theme {
        get {
            return shared.theme
        }
        set {
            
        }
    }
    
    func subscribeToChanges(_ object: AnyObject, handler: @escaping (Theme) -> Void)
}

protocol Themed {
    associatedtype _ThemeProvider: ThemeProvider
    
    var themeProvider: _ThemeProvider { get }
    
    func applyTheme(_ theme: _ThemeProvider.Theme)
}

extension Themed where Self: AnyObject {
    func setUpThemeing() {
        applyTheme(themeProvider.currentTheme)
        themeProvider.subscribeToChanges(self) { [weak self] newTheme in
            self?.applyTheme(newTheme)
        }
    }
}



struct AppTheme {
    var statusBarStyle: UIStatusBarStyle
}

extension AppTheme {
    static let light = AppTheme(statusBarStyle: .default)
}

final class AppThemeProvider: ThemeProvider {
    typealias Theme = AppTheme
    
    
}
