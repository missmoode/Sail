//
//  HoistAPI.swift
//  Sail
//
//  Created by Amy Harris on 12/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

class HoistAPI {
    enum RemoteError: Error {
        case generic(statusCode: Int, details: String)
    }

    struct Configuration: APIConfiguration {
        typealias RemoteAPIError = HoistAPI.RemoteError
        
        let rootURL: URL = URL(string: "https://hoist.getsail.app")!
        
        func mutateHTTPRequest(_ httpRequest: inout HTTPRequest) {
        }
        
        func parseRemoteError(statusCode: Int, data: Data?) -> RemoteAPIError {
            return RemoteError.generic(statusCode: statusCode, details: "")
        }
    }

}
