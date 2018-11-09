//
//  ForeignKey.swift
//  Sail
//
//  Created by Amy Harris on 06/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import PromiseKit

class ForeignKey<Model: Fetchable>: Codable {
    var key: String
    
    init(key: String, value: Model? = nil) {
        self.key = key
    }
    
    required init(from decoder: Decoder) throws {
        self.key = try decoder.singleValueContainer().decode(String.self)
    }
    
    func fetchValue(_ client: APIClient) -> Promise<Fetchable> {
        return Promise { fetchValue(client, completion: $0.resolve) }
    }
    
    fileprivate func fetchValue(_ client: APIClient, completion: @escaping (Fetchable?, Error?) -> Void) {
        return Model.fetch(client, key, completion)
    }
}

protocol Fetchable: Codable {
    typealias Fetcher = (APIClient, String, @escaping (Fetchable?, Error?) -> Void) -> Void
    
    static var fetch: Fetcher { get }
}

