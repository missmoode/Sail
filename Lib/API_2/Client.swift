//
//  APIClient.swift
//  Sail
//
//  Created by Amy Harris on 13/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import PromiseKit

enum APIError<RemoteAPIError: Error>: Error {
    case unknown
    case resolvingPath
    case requestFailed
    case decodingResponse
    case remote(_ error: RemoteAPIError)
}

class APIClient<Configuration: APIConfiguration> {
    typealias Error = APIError<Configuration.RemoteAPIError>
    
    private let error = Error.self
    private let decoder = JSONDecoder()
    
    let configuration: Configuration
    
    init(_ configuration: Configuration) {
        self.configuration = configuration
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    fileprivate func send<Request: APIRequest>(_ request: Request, completionHandler: @escaping (Request.Response?, Error?) -> Void) {
        do {
            var httpRequest = HTTPRequest(configuration.rootURL.appendingPathComponent(try request.resolvePath()), method: Request.method)
            
            switch Request.method {
            case .get:
                httpRequest.urlParameters = URLParameterEncoder.encode(request)
                break
            default:
                httpRequest.data = MultipartEncoder.encode(request)
                break
            }
            
            configuration.mutateHTTPRequest(&httpRequest)
            
            httpRequest.send { response, data, error in
                if let error = error {
                    switch (error) {
                    case .generic(let statusCode):
                        return completionHandler(nil, APIError.remote(self.configuration.parseRemoteError(statusCode: statusCode, data: data)))
                    case .requestFailed:
                        return completionHandler(nil, APIError.requestFailed)
                    }
                }
                
                do {
                    completionHandler(try self.decoder.decode(Request.Response.self, from: data!), nil)
                } catch {
                    completionHandler(nil, APIError.decodingResponse)
                }
            }
        } catch let error as APIError<Configuration.RemoteAPIError> {
            completionHandler(nil, error)
        } catch APIRequestError.resolvingPath {
            completionHandler(nil, APIError.resolvingPath)
        } catch {
            completionHandler(nil, APIError.unknown)
        }
    }
    
    // MARK: Redundant Requests
    
    private var activeRequests: [Int:[(Decodable?, Error?) -> Void]] = [:]
    
    fileprivate func fulfil<Request: APIRequest>(_ request: Request, completionHandler: @escaping (Request.Response?, Error?) -> Void) {
        var requests = activeRequests[request.hashValue] ?? []
        
        if requests.count == 0 {
            self.send(request) { response, error in
                if error == nil {
                    self.cache[request.hashValue] = CacheRecord(expireDate: Date.init(timeIntervalSinceNow: 30), content: response)
                }
                self.activeRequests[request.hashValue]?.forEach { completionHandler in
                    completionHandler(response, error)
                }
                self.activeRequests[request.hashValue] = nil
            }
        }
        
        requests.append { decodable, error in
            completionHandler(decodable as! Request.Response?, error)
        }
        
        activeRequests[request.hashValue] = requests
    }
    
    // MARK: Cache
    
    private var cache: [Int: CacheRecord] = [:]
    
    fileprivate func request<Request: APIRequest>(_ request: Request, forceNew: Bool, completionHandler: @escaping (Request.Response?, Error?) -> Void) {
        if let record = cache[request.hashValue] {
            if record.hasExpired() || forceNew {
                cache[request.hashValue] = nil
            } else {
                return completionHandler((record.content as! Request.Response), nil)
            }
        }
        
        self.fulfil(request, completionHandler: completionHandler)
    }
    
    struct CacheRecord {
        var expireDate: Date
        let content: Decodable
        
        func hasExpired() -> Bool {
            return expireDate.timeIntervalSinceNow.sign == .minus
        }
        
        mutating func expire() {
            expireDate = Date.init()
        }
    }
    
    func request<Request: APIRequest>(_ request: Request, forceNew: Bool = false) -> Promise<Request.Response> {
        return Promise {
            self.request(request, forceNew: forceNew, completionHandler: $0.resolve)
        }
    }
}

protocol APIConfiguration {
    associatedtype RemoteAPIError: Error
    
    var rootURL: URL { get }
    
    func mutateHTTPRequest(_ httpRequest: inout HTTPRequest)
    func parseRemoteError(statusCode: Int, data: Data?) -> RemoteAPIError
}
