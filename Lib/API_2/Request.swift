//
//  Request.swift
//  Sail
//
//  Created by Amy Harris on 13/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

protocol APIRequest: Hashable {
    associatedtype Response: Decodable
    
    static var resourcePath: String { get }
    static var method: HTTPRequestMethod { get }
}

enum APIRequestError: Error {
    case resolvingPath
}

extension APIRequest {
    func resolvePath() throws -> String {
        do {
            var path = Self.resourcePath
            
            let regex = try NSRegularExpression(pattern: ":([\\w|\\d]*):")
            let results = regex.matches(in: path, range: NSRange(path.startIndex..., in: path))
            
            let mirror = Mirror(reflecting: self)
            
            results.map {
                String(path[Range($0.range(at: 1), in: path)!])
            }.forEach { param in
                let value = mirror.children.first(where: {$0.label == param})!.value
                
                path = path.replacingOccurrences(of: ":" + param + ":", with: String(describing: value))
            }
            
            
            print("Path" + path)
            
            return path
        } catch {
            throw APIRequestError.resolvingPath
        }
    }
}
