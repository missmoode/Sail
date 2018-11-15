//
//  URLParameterEncoder.swift
//  Sail
//
//  Created by Amy Harris on 06/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

class URLParameterEncoder {
    public static func encode<T: APIRequest>(_ encodable: T) -> [URLQueryItem] {
        return Mirror(reflecting: encodable).children.compactMap { child in
            if !(child.label?.starts(with: "_"))! {
                return nil
            } else {
                return URLQueryItem(name:  APIUtil.snakeCased(child.label!)!, value: String(describing: child.value))
            }
            
        }
    }
}
