//
//  InstanceMethods.swift
//  Sail
//
//  Created by Amy Harris on 05/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

struct GetInstanceInfo: APIRequest {
    typealias Response = MInstance
    
    var resourceName: String {
        return "/instance"
    }
    
    var method: HTTPRequestMethod {
        return .get
    }
}
