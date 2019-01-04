//
//  LoginSession.swift
//  Sail
//
//  Created by Amy Harris on 12/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import KeychainAccess

let keychain = Keychain(service: "app.gethoist.sail")

struct LoginSession {
    public let uuid: UUID
    public let instanceUrl: URL
    public lazy var client = APIClient(MastodonAPI.Configuration(instanceUrl, token: loginToken))
    public let store: Store<SessionState, SessionState.Action>
    
    var loginToken: String {
        get { return keychain["token/\(instanceUrl.absoluteString.hashValue)\(uuid.uuidString.hashValue))"]! }
        set { keychain["token/\(instanceUrl.absoluteString.hashValue)\(uuid.uuidString.hashValue))"] = newValue }
    }
    
    init(instanceURL: URL, token: String) {
        self.instanceUrl = instanceURL
        self.uuid = UUID()
        self.store = Store<SessionState, SessionState.Action>(SessionState.reducer, with: SessionState(uuid))
        
        self.loginToken = token
    }
}

extension LoginSession: Codable {
    private enum CodingKeys: String, CodingKey {
        case uuid
        case instanceUrl
        case store = "state"
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.instanceUrl = try values.decode(URL.self, forKey: .instanceUrl)
        self.uuid = try values.decode(UUID.self, forKey: .uuid)
        
        self.store = Store<SessionState, SessionState.Action>(SessionState.reducer, with: try values.decode(SessionState.self, forKey: .store))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(instanceUrl, forKey: .instanceUrl)
        
        try container.encode(store.state, forKey: .store)
    }
}

struct SessionState: Codable {
    var account: Cache<MAccount>
    var timelines: [String: Timeline]
    
    init(_ uuid: UUID) {
        self.account = Cache<MAccount>(uuid.uuidString)
        timelines = [:]
    }
    
    public enum Action {
        case REFRESH
    }
    
    static var reducer: (Action, SessionState) -> SessionState {
        return {action, state in
            return state
        }
    }
}

//
//protocol StatusSection: Codable {
//}
//struct MissingStatusSection: StatusSection {
//
//}
//struct AvailableStatusSection: StatusSection {
//    var statuses: [MStatus]
//}

struct Timeline: Codable {
    var unread: [MStatus]
//    var history: [StatusSection]
    var location: Int // Current location in the history, will always be 0 or higher as if you scroll to an unread it will be moved to history

    // func markAsRead (move into the first status section in the history (if it's not an available status section, make one and put it as the first))
}
