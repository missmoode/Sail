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
            
            static var resourcePath: String {
                return "/instances/:_address:/info"
            }
            
            static var method: HTTPRequestMethod {
                return .get
            }
            
            let _address: String?
            
            init(address: String? = nil) {
                self._address = address
            }
        }
    }
}
