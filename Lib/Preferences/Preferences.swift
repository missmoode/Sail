//
//  Preferences.swift
//  Sail
//
//  Created by Amy Harris on 11/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

var userDefaults = UserDefaults.standard

struct Preferences {
    static let CurrentSessionID = Preference<UUID?>("current_session_id", default: nil)
    static let CurrentThemeIndex = Preference<Int>("current_theme_index", default: 0)
    
    class Preference<Type> {
        private let key: String
        var subscribable: SubscribableValue<Type>
        var value: Type {
            get {
                return self.subscribable.value
            }
            set {
                self.subscribable.value = newValue
            }
            
        }
        
        init(_ key: String, default def: Type) {
            self.key = key
            var object = userDefaults.object(forKey: key)
            if object == nil {
                object = def
            }
            self.subscribable = SubscribableValue<Type>(value: object as! Type)
            
            self.subscribable.subscribe(self, using: { value in
                userDefaults.set(value, forKey: key)
            })
        }
    }
}
