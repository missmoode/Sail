//
//  APIResponse.swift
//  Sail
//
//  Created by Amy Harris on 06/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

struct APIResponse<ResponseType: Decodable> {
    let decoded: Decodable?
    let error: Error?
}
