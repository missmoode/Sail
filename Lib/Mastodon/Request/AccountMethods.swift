//
//  AccountMethods.swift
//  Sail
//
//  Created by Amy Harris on 05/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation


extension MastodonAPI {
    class Account {
        struct Get: APIRequest {
            var resourceName: String {
                return "/api/v1/accounts/" + self.id!
            }
            
            var method: HTTPRequestMethod {
                return .get
            }
            
            typealias Response = MAccount
            
            let id: String?
            
            init(id: String? = nil) {
                self.id = id
            }
        }
        
        struct VerifyCredentials: APIRequest {
            var resourceName: String {
                return "/api/v1/accounts/verify_credentials"
            }
            
            var method: HTTPRequestMethod {
                return .get
            }
            
            typealias Response = MAccount
        }
        
        struct GetStatuses: APIRequest {
            typealias Response = MAccount
            
            var resourceName: String {
                return "/api/v1/accounts/\(self.id)/statuses"
            }
            
            var method: HTTPRequestMethod {
                return .get
            }
            
            let id: String
            
            init(id: String) {
                self.id = id
            }
        }
        
        struct CredentialVerificationGateway: APIRequestGateway {
            let apiURL: URL
            let token: String
            
            func mutateHTTPRequest(_ request: inout HTTPRequest) {
                request.headers["Authorization"] = "Bearer \(token)"
            }
        }
    }
}
