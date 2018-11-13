//
//  AccountManager.swift
//  Sail
//
//  Created by Amy Harris on 03/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import Disk

class SessionStore {
    fileprivate static var memCache: [UUID:LoginSession]?
    static var sessions: [UUID:LoginSession] {
        set {
            memCache = newValue
            do {
                try Disk.save(memCache, to: .applicationSupport, as: "sessions.json")
            } catch {
                fatalError("Unable to save sessions: \(error)")
            }
        }
        get {
            if memCache == nil {
                do {
                    try memCache = Disk.retrieve("sessions.json", from: .applicationSupport, as: [UUID:LoginSession].self)
                } catch {
                    memCache = [:]
                }
            }
            return memCache!
        }
    }
    
    static func invalidateCache() {
        memCache = nil
    }
}
