//
//  Service.swift
//  Sail
//
//  Created by Amy Harris on 03/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

protocol Event {
    
}

protocol EventObserver: class {
    func handleEvent(_ event: Event)
}

class EventService {
    
    static var observers = [EventObserver]()
    
    static func registerObserver(_ observer: EventObserver)  {
        observers.append(observer)
    }
    static func unregisterObserver(_ observer: EventObserver)  {
        if let index = observers.firstIndex(where: {$0 === observer}) {
            observers.remove(at: index)
        }
    }
    
    static func dispatchEvent<T: Event>(_ event: T) {
        observers.forEach({$0.handleEvent(event)})
    }
}

enum EventError: Error {
    case awaitTimeoutError
}

