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
    
    let sessions: SessionsModel
    let themes: ThemeModel
    
    public static func load() -> StateDefaults {
        return StateDefaults(
            sessions: loadOrDefault(SessionsModel.self, default: SessionsModel(currentSessionIndex: -1, sessionsList: [])),
            themes: loadOrDefault(ThemeModel.self, default: ThemeModel(currentThemeIndex: 0))
        )
    }
    
    private static func loadOrDefault<Model: Decodable>(_ model: Model.Type, default state: Model) -> Model {
        if let data = userDefaults.data(forKey: String(describing: model)) {
            do {
                return try decoder.decode(model, from: data)
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
    
    static var sessionStore = Store<SessionsModel, SessionsModel.Action>(SessionsModel.reducer, with: defaults.sessions)
    static var themeStore = Store<ThemeModel, ThemeModel.Action>(ThemeModel.reducer, with: defaults.themes)
    
    class SaveLink {
        static let `default` = SaveLink()
    }
    
    static func beginSaving() {
        sessionStore.subscribe(SaveLink.default, handler: save)
        themeStore.subscribe(SaveLink.default, handler: save)
    }
    
    private static func save<Model: Encodable>(state: Model) {
        do {
            userDefaults.set(try encoder.encode(state), forKey: String(describing: Model.self))
        } catch {
            
        }
    }
}
