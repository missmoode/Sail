//
//  Preferences.swift
//  Sail
//
//  Created by Amy Harris on 11/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

var userDefaults = UserDefaults.standard

struct StateDefaults {
    private static var decoder = JSONDecoder()
    
    let sessions: [LoginSession]
    let settings: SettingsContainer
    
    public static func load() -> StateDefaults {
        return StateDefaults(
            sessions: loadOrDefault("sessions", default: []),
            settings: loadOrDefault("settings", default: SettingsContainer())
        )
    }
    
    private static func loadOrDefault<Model: Decodable>(_ key: String, default state: Model) -> Model {
        if let data = userDefaults.data(forKey: key) {
            do {
                return try decoder.decode(type(of: state), from: data)
            } catch {
                // TODO display alert saying error occured and we have to reset to default
            }
        }
        return state
    }
}

struct Stores {
    private static var encoder = JSONEncoder()
    
    private static var defaults: StateDefaults = StateDefaults.load()
    
    static var sessionStore = Store(SessionStoreReducer, with: defaults.sessions)
    static var settingsStore = Store(SettingStoreReducer, with: defaults.settings)
    
    class SaveLink {
        static let `default` = SaveLink()
    }
    
    static func beginSaving() {
        sessionStore.subscribe(SaveLink.default, handler: save)
        settingsStore.subscribe(SaveLink.default, handler: save)
    }
    
    private static func save<Model: Encodable>(state: Model) {
        do {
            userDefaults.set(try encoder.encode(state), forKey: String(describing: Model.self))
        } catch {
            
        }
    }
}
