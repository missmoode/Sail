//
//  HTTPRequest.swift
//  Sail
//
//  Created by Amy Harris on 05/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

struct HTTPRequest: Hashable {
    public var url: URL
    public var method: HTTPRequestMethod
    
    public var data: Data?
    public var urlParameters: [URLQueryItem] = []
    public var headers: [String:String] = [:]
    
    init(_ url: URL, method: HTTPRequestMethod) {
        self.url = url
        self.method = method
    }
    
    public func send(completionHandler: @escaping (HTTPURLResponse?, Data?, HTTPError?) -> Void) {
        
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = data
        headers.forEach { header in
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else {
                    return completionHandler(nil, nil, HTTPError.requestFailed)
                }
                
                if (httpResponse.statusCode == 200) {
                    completionHandler(httpResponse, data, nil)
                } else {
                    completionHandler(httpResponse, data, HTTPError.generic(statusCode: httpResponse.statusCode))
                }
            }
        }
        
        task.resume()
    }
}
