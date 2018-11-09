//
//  QuantumReference.swift
//  Sail
//
//  Created by Amy Harris on 30/10/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import PromiseKit

class NestWrapper<Model: Codable>: Codable {
    var value: Model
    
    required init(from decoder: Decoder) throws {
        self.value = try Model(from: decoder)
        
        // Todo: Set a maximum amount of nestings allowed
    }
}

