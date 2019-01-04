//
//  Store.swift
//  Sail
//
//  Created by Amy Harris on 22/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reservedre.
//

import Foundation

struct Store<Model, Action> {
    typealias Reducer = (Action, Model) -> Model
    
    private typealias Subscription = (object: Weak<AnyObject>, handler: (Model) -> Void)
    private var subscriptions: [Subscription] = []
    
    private let reducer: Reducer
    
    var state: Model {
        didSet {
            for (object, handler) in subscriptions where object.value != nil {
                handler(state)
            }
        }
    }
    
    init(_ reducer: @escaping Reducer, with state: Model) {
        self.reducer = reducer
        self.state = state
    }
    
    mutating func dispatch(_ action: Action) {
        self.state = self.reducer(action, self.state)
    }
    
    
    private mutating func cleanupSubscriptions() {
        subscriptions = subscriptions.filter({ entry in
            return entry.object.value != nil
        })
    }
    
    mutating func subscribe(_ object: AnyObject, handler: @escaping (Model) -> Void) {
        cleanupSubscriptions()
        subscriptions.append(Subscription(object: Weak(value: object), handler: handler))
    }
}
