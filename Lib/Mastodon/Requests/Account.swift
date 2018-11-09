//
//  Account.swift
//  Sail
//
//  Created by Amy Harris on 30/10/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

struct GetAccount: APIRequest {
    var resourceName: String {
        return "accounts/" + self.id!
    }
    
    var method: RequestMethod {
        return .get
    }
    
    typealias Response = MAccount
    
    let id: String?
    
    init(id: String? = nil) {
        self.id = id
    }
}

struct GetAccountStatuses: APIRequest {
    var resourceName: String {
        return "accounts/" + self.id! + "/statuses"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    typealias Response = MAccount
    
    let id: String?
    
    init(id: String? = nil) {
        self.id = id
    }
}
