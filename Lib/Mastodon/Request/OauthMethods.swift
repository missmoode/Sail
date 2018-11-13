//
//  OauthMethods.swift
//  Sail
//
//  Created by Amy Harris on 12/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

extension MastodonAPI {
    class Oauth {
        class Authorize {
            struct GetInfo: APIRequest {
                typealias Response = MInstance
                
                var resourceName: String {
                    return "/oauth/authorize"
                }
                
                var method: HTTPRequestMethod {
                    return .get
                }
            
                let responseType = "code"
                let clientId: String
                let redirectUri = "https://hoist.getsail.app/authentication/authorize"
                let scope = "read write follow push"
                let state: String
                
                init(clientId: String, address: String) {
                    self.clientId = clientId
                    self.state = "{\"address\":\"\(address)\"}"
                }
            }
        }
    }
}
