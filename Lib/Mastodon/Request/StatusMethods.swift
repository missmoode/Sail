//
//  StatusMethods.swift
//  Sail
//
//  Created by Amy Harris on 05/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

struct GetStatus: APIRequest {
    typealias Response = MStatus
    
    var resourceName: String {
        return "/statuses/\(self.id)"
    }
    
    var method: HTTPRequestMethod {
        return .get
    }
    
    let id: String
    
    init(id: String) {
        self.id = id
    }
}

struct GetTimelines: APIRequest {
    typealias Response = [MStatus]
    
    var resourceName: String {
        return "/statuses/\(self.id)"
    }
    
    var method: HTTPRequestMethod {
        return .get
    }
    
    let id: String
    
    init(id: String) {
        self.id = id
    }
}
