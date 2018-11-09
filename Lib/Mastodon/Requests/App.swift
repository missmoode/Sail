//
//  App.swift
//  Sail
//
//  Created by Amy Harris on 29/10/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

struct RegisterApp: APIRequest {
    typealias Response = OAuthApp
    
    var resourceName: String {
        return "apps"
    }
    
    var method: RequestMethod {
        return .post
    }
    
    let clientName: String
    let redirectUris: [String]
    let scopes: String
    
    init(clientName: String = "Sail", redirectUris: [String] = ["sail://oauth/callback"], scopes: String = "read write follow push") {
        self.clientName = clientName
        self.redirectUris = redirectUris
        self.scopes = scopes
    }
}
