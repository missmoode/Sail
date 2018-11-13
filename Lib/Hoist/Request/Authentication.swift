//
//  Authentication.swift
//  Sail
//
//  Created by Amy Harris on 01/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

extension HoistAPI {
    class Authentication {
        struct GetInstanceInfo: APIRequest {
            typealias Response = HMastodonInfo
            
            var resourceName: String {
                return "/instances/" + self.address! + "/info"
            }
            
            var method: HTTPRequestMethod {
                return .get
            }
            
            let address: String?
            
            init(address: String? = nil) {
                self.address = address
            }
        }
    }
}
