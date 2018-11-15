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

struct LoginSession: Codable {
    let uuid: UUID
    let instanceUrl: URL
    
    var loginToken: String {
        get { return keychain["token/\(instanceUrl.absoluteString.hashValue)\(uuid.uuidString.hashValue))"]! }
        set { keychain["token/\(instanceUrl.absoluteString.hashValue)\(uuid.uuidString.hashValue))"] = newValue }
    }
    
    var api: APIClient<MastodonAPI.Configuration> {
        get { return APIClient(MastodonAPI.Configuration(self.instanceUrl, token: self.loginToken)) }
    }
    
    init(instanceURL: URL, token: String) {
        self.instanceUrl = instanceURL
        self.uuid = UUID()
        self.loginToken = token
    }
}
