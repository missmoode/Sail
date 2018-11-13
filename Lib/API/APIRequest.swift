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

extension APIRequest {
    func createHTTPRequest(with gateway: APIRequestGateway) -> HTTPRequest {
        var httpRequest = HTTPRequest(gateway.apiURL.appendingPathComponent(resourceName), method: method)
        
        switch method {
        case .get:
            httpRequest.urlParameters = URLParameterEncoder.encode(self)
            break
        default:
            httpRequest.data = MultipartEncoder.encode(self)
            break
        }
        
        gateway.mutateHTTPRequest(&httpRequest)
        
        return httpRequest
    }
    
    func send(with gateway: APIRequestGateway) -> Promise<Response> {
        return Promise { promise in
            
            self.createHTTPRequest(with: gateway).send { httpResponse, data, error in
                if let error = error {
                    promise.reject(error)
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        try promise.fulfill(decoder.decode(Response.self, from: data))
                    } catch {
                        promise.reject(APIError.decoding)
                    }
                }
            }
        }
    }
}

class HTTPRequestGateway: APIRequestGateway {
    func sendRequest()
 }
