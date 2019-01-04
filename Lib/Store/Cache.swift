//
//  Cache.swift
//  Sail
//
//  Created by Amy Harris on 28/12/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import Disk

fileprivate class CacheStore {
    static var values: [String:AnyObject] = [:]
}

class Cache<T: Codable>: Codable {
    
    public static func shared(name: String) -> Cache<T> {
        let name = "\(String.init(describing: T.self))-\(name)"
        if CacheStore.values[name] == nil {
            CacheStore.values[name] = Cache<T>(name)
        }
        return CacheStore.values[name] as! Cache<T>
    }
    
    private var memoryCache: Weak<AnyObject> = Weak(value: nil)
    
    private let name: String
    private var updatedAt: Date
    
    init(_ name: String) {
        self.name = name
        self.memoryCache = Weak(value: nil)
        self.updatedAt = Date.distantPast
    }
    
    convenience init(_ name: String, with: T) {
        self.init(name)
        self.value = with
        self.updatedAt = Date.init()
    }
    
    public var age: TimeInterval {
        get {
            return updatedAt.timeIntervalSinceNow
        }
    }
    
    public var value: T? {
        get {
            if memoryCache.value == nil {
                do {
                    memoryCache.value = try Disk.retrieve(name, from: .caches, as: T.self) as AnyObject
                } catch {
                    return nil
                }
            }
            
            return (memoryCache.value as! T)
        }
        set {
            memoryCache.value = newValue as AnyObject
            do {
                if newValue == nil {
                    try Disk.remove(name, from: .caches)
                } else {
                    try Disk.save(newValue, to: .caches, as: name)
                }
            } catch {
                fatalError()
            }
        }
    }
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case updatedAt
    }
}
