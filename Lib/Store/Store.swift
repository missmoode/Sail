//
//  Store.swift
//  Sail
//
//  Created by Amy Harris on 22/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reservedre.
//

import Foundation

protocol Action {
    func run(_ completionHandler: @escaping (Any?, Error?) -> Void)
}

protocol StoreType {
    func apply(_ update: Any)
}

class Store<Model>: StoreType {
    typealias Reducer = (Any, Model) -> Model
    
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
    
    func apply(_ update: Any) {
        self.state = self.reducer(update, self.state)
    }
    
    
    private func cleanupSubscriptions() {
        subscriptions = subscriptions.filter({ entry in
            return entry.object.value != nil
        })
    }
    
    func subscribe(_ object: AnyObject, handler: @escaping (Model) -> Void) {
        cleanupSubscriptions()
        subscriptions.append(Subscription(object: Weak(value: object), handler: handler))
    }
}

class AppDispatcher {
    static private var stores: [StoreType] = []
    
    private init() {
        
    }
    
    static func connectStore<Model>(_ store: Store<Model>) {
        stores.append(store)
    }
    
    static func dispatch(_ action: Action, completionHandler: @escaping (Error?) -> Void) {
        print("Dispatching action: " + String(describing: action))
        action.run { (update, error) in
            if let update = update {
                for store in stores {
                    store.apply(update)
                }
                completionHandler(nil)
            } else if let error = error {
                completionHandler(error)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    static func dispatch(_ action: Action) {
        dispatch(action) { (error) in
            
        }
    }
}
