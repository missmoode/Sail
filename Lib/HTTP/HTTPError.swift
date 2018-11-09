//
//  HTTPError.swift
//  Sail
//
//  Created by Amy Harris on 05/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

public enum HTTPError: Error {
    case requestFailed
    case generic(statusCode: Int)
}
