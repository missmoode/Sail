//
//  TokenIngestAction.swift
//  Sail
//
//  Created by Amy Harris on 05/01/2019.
//  Copyright © 2019 Amelia Harris. All rights reserved.
//

import Foundation

struct TokenIngestAction: Action {
    let token: String
    let address: String
    
    func run(_ completionHandler: @escaping (Any?, Error?) -> Void) {
        let session = LoginSession(instanceURL: URL(string: address)!, token: token)
        completionHandler(SessionUpdate.add(session: session), nil);
    }
    
    
}
