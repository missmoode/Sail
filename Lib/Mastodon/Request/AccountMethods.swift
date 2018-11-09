//
//  AccountMethods.swift
//  Sail
//
//  Created by Amy Harris on 05/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

struct GetAccount: APIRequest {
    var resourceName: String {
        return "/accounts/" + self.id!
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
        return "/accounts/verify_credentials"
    }
    
    var method: HTTPRequestMethod {
        return .get
    }
    
    typealias Response = MAccount
}

struct GetAccountStatuses: APIRequest {
    typealias Response = MAccount
    
    var resourceName: String {
        return "/accounts/\(self.id)/statuses"
    }
    
    var method: HTTPRequestMethod {
        return .get
    }
    
    let id: String
    
    init(id: String) {
        self.id = id
    }
}
