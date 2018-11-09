//
//  APIError.swift
//  Sail
//
//  Created by Amy Harris on 02/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case encoding
    case decoding
    case unauthorized
    case generic
    
    static func from(_ error: HTTPError) -> APIError {
        switch error {
        case .generic(statusCode: 401):
            return .unauthorized
        default:
            return .generic
        }
    }
}
