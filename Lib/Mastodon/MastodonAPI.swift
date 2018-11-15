//
//  MastodonAPI.swift
//  Sail
//
//  Created by Amy Harris on 12/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

class MastodonAPI {
    enum RemoteError: Error {
        case generic(statusCode: Int, details: String)
    }

    struct Configuration: APIConfiguration {
        typealias RemoteAPIError = MastodonAPI.RemoteError
        
        let rootURL: URL
        let token: String?
        
        init(_ rootURL: URL, token: String? = nil) {
            self.rootURL = rootURL
            self.token = token
        }
        
        func mutateHTTPRequest(_ httpRequest: inout HTTPRequest) {
            if let token = token {
                httpRequest.headers["Authorization"] = "Bearer \(token)"
            }
        }
        
        func parseRemoteError(statusCode: Int, data: Data?) -> RemoteError {
            return RemoteError.generic(statusCode: statusCode, details: "")
        }
    }
}
