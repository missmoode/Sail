//
//  Authentication.swift
//  Sail
//
//  Created by Amy Harris on 01/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

struct GetClientID: APIRequest {
    typealias Response = [HClientID]
    
    var resourceName: String {
        return "authentication/instance/" + self.address!
    }
    
    var method: RequestMethod {
        return .get
    }
    
    typealias Response = MAccount
    
    let address: String?
    
    init(address: String? = nil) {
        self.address = address
    }
}
