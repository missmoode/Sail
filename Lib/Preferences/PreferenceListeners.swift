//
//  PersonalizationProvider.swift
//  Sail
//
//  Created by Amy Harris on 08/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

protocol Personalized {
    func applyPersonalization(session: LoginSession)
}

extension Personalized where Self: AnyObject {
    func setUpPersonalisation() {
//        self.applyPersonalization(session: Stores.sessionStore.state.currentSession)
//        Stores.sessionStore.subscribe(self) {[weak self] state in
//            self?.applyPersonalization(session: state.currentSession)
//        }
    }
}


protocol Themed {
    func applyTheme(theme: Theme)
}

extension Themed where Self: AnyObject {
    func setUpThemeing() {
        self.applyTheme(theme: Stores.settingsStore.state.currentTheme)
        Stores.settingsStore.subscribe(self) { [weak self] state in
            self?.applyTheme(theme: state.currentTheme)
        }
    }
}
