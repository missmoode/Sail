//
//  ColorTheme.swift
//  Sail
//
//  Created by Amy Harris on 08/11/2018.
//  Based on https://www.latenightswift.com/2018/04/26/implementing-night-mode/
//

import Foundation
import UIKit
protocol Themed {
    func applyTheme(theme: Theme)
}

extension Themed where Self: AnyObject {
    func setUpThemeing() {
        self.applyTheme(theme: ThemeProvider.currentTheme)
        ThemeProvider.subscribeToChanges(self) { [weak self] newTheme in
            self?.applyTheme(theme: newTheme)
        }
    }
}

class ThemeProvider {
    private static var theme: SubscribableValue<Theme> = SubscribableValue<Theme>(value: .light)
    
    static var currentTheme: Theme {
        get {
            return theme.value
        } set {
            theme.value = newValue
        }
    }
    
    static func subscribeToChanges(_ object: Themed, handler: @escaping (Theme) -> Void) {
        self.theme.subscribe(object as AnyObject, using: handler)
    }
}
