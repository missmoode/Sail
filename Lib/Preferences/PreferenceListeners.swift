//
//  PersonalizationProvider.swift
//  Sail
//
//  Created by Amy Harris on 08/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation


protocol Personalized {
    func applyPersonalization(account: MAccount)
}

extension Personalized where Self: AnyObject {
    func setUpPersonalisation() {
        self.applyPersonalization(session: SessionStore.sessions[Preferences.CurrentSessionID.value])
        Preferences.CurrentSessionID.subscribable.subscribe(self) { [weak self] newSessionID in
            self?.applyPersonalization(session: SessionStore.sessions[newSessionID])
        }
    }
}


protocol Themed {
    func applyTheme(theme: Theme)
}

extension Themed where Self: AnyObject {
    func setUpThemeing() {
        self.applyTheme(theme: Theme.themes[Preferences.CurrentThemeIndex.value])
        Preferences.CurrentThemeIndex.subscribable.subscribe(self) { [weak self] newThemeIndex in
            self?.applyTheme(theme: Theme.themes[newThemeIndex])
        }
    }
}
