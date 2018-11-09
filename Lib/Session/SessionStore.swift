//
//  AccountManager.swift
//  Sail
//
//  Created by Amy Harris on 03/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import UIKit
import KeychainAccess
import PromiseKit
import JGProgressHUD
import Disk

let keychain = Keychain(service: "app.gethoist.sail")

struct LoginSession: Codable {
    var instanceUrl: URL
    var accountID: String
    var cacheID: UUID
    var loginToken: String {
        get { return keychain["token/\((cacheID.uuidString+accountID).hashValue)"]! }
        set { keychain["token/\((cacheID.uuidString+accountID).hashValue)"] = newValue }
    }
    var client: MastodonAPIClient {
        get {
            return MastodonAPIClient(instanceUrl, token: loginToken)
        }
    }
}

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
