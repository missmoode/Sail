//
//  URLParameterEncoder.swift
//  Sail
//
//  Created by Amy Harris on 06/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

class URLParameterEncoder {
    public static func encode<T: Encodable>(_ encodable: T, convertToSnakeCase: Bool = true) -> [URLQueryItem] {
        return Mirror(reflecting: encodable).children.map { URLQueryItem(name: $0.label!.snakeCased()!, value: String(describing: $0.value))}
    }
    
    

}
