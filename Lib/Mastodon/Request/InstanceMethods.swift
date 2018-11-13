//
//  InstanceMethods.swift
//  Sail
//
//  Created by Amy Harris on 05/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

extension MastodonAPI {
    class Instance {
        struct GetInfo: APIRequest {
            typealias Response = MInstance
            
            var resourceName: String {
                return "/api/v1/instance"
            }
            
            var method: HTTPRequestMethod {
                return .get
            }
        }
    }
}
