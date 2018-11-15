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
        struct GetInfo: APIRequest {
            typealias Response = MAccount
            
            static var resourcePath: String {
                return "/api/v1/accounts/:_id:"
            }
            
            static var method: HTTPRequestMethod {
                return .get
            }
            
            let _id: String
            
            init(id: String) {
                self._id = id
            }
        }
        
        struct GetStatuses: APIRequest {
            typealias Response = [MStatus]
            
            static var resourcePath: String {
                return "/api/v1/statuses/:_id:/statuses"
            }
            
            static var method: HTTPRequestMethod {
                return .get
            }
            
            let _id: String
            
            init(id: String) {
                self._id = id
            }
        }
        
        struct GetSelf: APIRequest {
            static var resourcePath: String {
                return "/api/v1/accounts/verify_credentials"
            }
            
            static var method: HTTPRequestMethod {
                return .get
            }
            
            typealias Response = MAccount
        }
    }
}
