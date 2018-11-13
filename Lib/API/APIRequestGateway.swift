//
//  APIRequestGateway.swift
//  Sail
//
//  Created by Amy Harris on 11/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

protocol APIRequestGateway {
    var apiURL: URL { get }
    func mutateHTTPRequest(_ request: inout HTTPRequest)
}

struct GenericAPIRequestGateway: APIRequestGateway {
    let apiURL: URL
    
    func mutateHTTPRequest(_ request: inout HTTPRequest) {
        //Do nothing
    }
}
