//
//  APIClient.swift
//  Sail
//
//  Created by Amy Harris on 26/10/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import PromiseKit

protocol APIRequest: Encodable, Hashable {
    associatedtype Response: Decodable
    
    var resourceName: String { get }
    var method: HTTPRequestMethod { get }
}

class APIClient {
    let rootURL: URL
    let decoder = JSONDecoder()
    
    init(_ rootURL: URL) {
        self.rootURL = rootURL
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func getMutators<T: APIRequest>(for request: T) -> [HTTPRequestMutator] {
        return []
    }
    
    func execute<T: APIRequest>(_ request: T) -> Promise<T.Response> {
        return Promise { self.execute(request, completionHandler: $0.resolve) }
    }
    
    func execute<T: APIRequest>(_ request: T, completionHandler: @escaping (T.Response?, Error?) -> Void) {
        let fullURL = rootURL.appendingPathComponent(request.resourceName)
        var httpRequest = HTTPRequest(fullURL, method: request.method)
        
        switch request.method {
        case .get:
            httpRequest.urlParameters = URLParameterEncoder.encode(request)
            break
        default:
            httpRequest.data = MultipartEncoder.encode(request)
            break
        }
        
        httpRequest.mutate(with: getMutators(for: request))
        
        httpRequest.send { httpResponse, data, error in
            if let error = error {
                completionHandler(nil, error)
            } else if let data = data {
                do {
                    try completionHandler(self.decoder.decode(T.Response.self, from: data), nil)
                } catch {
                    print(error)
                    completionHandler(nil, APIError.decoding)
                }
            }
        }
    }
}
