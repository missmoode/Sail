//
//  AccountManager.swift
//  Sail
//
//  Created by Amy Harris on 03/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import Disk

struct SessionsModel: Codable {
    var currentSessionIndex: Int
    var currentSession: LoginSession { return sessionsList[currentSessionIndex] }
    var sessionsList: [LoginSession]
    
    enum Action {
        case add(LoginSession)
        case remove(LoginSession)
        case setCurrent(LoginSession)
    }
    
    static var reducer: (Action, SessionsModel) -> SessionsModel {
        return {action, state in
            var state = state
            
            switch action {
            case .add(let session):
                state.sessionsList.append(session)
                break
            case .remove(let session):
                state.sessionsList.remove(at: state.sessionsList.firstIndex(where: {$0.uuid == session.uuid})!)
                break
            case .setCurrent(let session):
                state.currentSessionIndex = state.sessionsList.firstIndex(where: {$0.uuid == session.uuid})!
                break
            }
            
            return state
        }
    }
}
