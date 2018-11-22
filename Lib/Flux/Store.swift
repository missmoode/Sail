//
//  Store.swift
//  Sail
//
//  Created by Amy Harris on 22/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

typealias Reducer = (State?) -> State   

protocol State: Codable {
    
}

struct AppState: State {
    let sessions: Session
}

protocol Action {
    associatedtype StateType
}

enum SessionAction: Action {
    typealias StateType = AppState
    
    case add
    case remove
    
    func reduce(state: SessionAction.StateType?) -> SessionAction.StateType {
        switch self {
        case .add:
            return state!
        case .remove:
            return state!
        default:
            return state ?? SessionAction.defaultState
        }
    }
}

class Store {
    
    func dispatch(_ action: Action) {
        action.reduce(state: <#T##State?#>)
    }
}
