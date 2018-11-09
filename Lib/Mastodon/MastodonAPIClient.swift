//
//  MastodonAPIClient.swift
//  Sail
//
//  Created by Amy Harris on 05/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

class MastodonAPIClient: APIClient {
    
    var authorizationMutator: HTTPRequestMutator {
        return { req in
            if let token = self.token {
                req.headers["Authorization"] = "Bearer \(token)"
            }
        }
    }
    
    override func getMutators<T>(for request: T) -> [HTTPRequestMutator] where T : APIRequest {
        return [authorizationMutator]
    }
    
    
    var token: String?
    
    init(_ url: String, token: String? = nil) {
        super.init(url + "/api/v1")
        self.token = token
    }
}
