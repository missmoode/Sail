//
//  Session.swift
//  Sail
//
//  Created by Amy Harris on 05/01/2019.
//  Copyright © 2019 Amelia Harris. All rights reserved.
//

import Foundation

let SessionStoreReducer: (Any, [LoginSession]) -> [LoginSession] = {update, state in
    
    var state = state
    
    if let update = update as? SessionUpdate {
        switch update {
        case .add(let session):
            state.append(session)
            break
        case .remove(let session):
            state.remove(at: state.firstIndex(where: {$0.uuid == session.uuid})!)
            break
        }
    }
    
    return state
}
