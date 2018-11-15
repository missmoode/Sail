//
//  MultipartEncoder.swift
//  Sail
//
//  Created by Amy Harris on 06/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import UIKit

class MultipartEncoder {
    static let boundary = "--\(UUID().uuidString) \r\n"
    
    public static func encode<T: APIRequest>(_ encodable: T) -> Data {
        var body = Data()
        
        Mirror(reflecting: encodable).children.forEach { child in
            if !(child.label?.starts(with: "_"))! {
                body.append(EncodingStrategy.encode(child.value, withName: APIUtil.snakeCased(child.label!)!))
            }
        }
        body.appendString(boundary)
        
        return body
    }
    
    struct EncodingStrategy {
        public static func encode(_ value: Any, withName name: String) -> Data {
            return getEncoder(for: value)(name)
        }
        
        public static func getEncoder(for value: Any) -> (Any) -> Data {
            switch value {
            case is UIImage:
                return encoder(image: value as! UIImage)
            default:
                return encoder(primative: value)
            }
        }
        
        private static func encoder(primative value: Any) -> (Any) -> Data {
            return { name in
                var body = Data()
                body.appendString(boundary)
                body.appendString("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
                return body
            }
        }
        
        
        private static func encoder(image value: UIImage) -> (Any) -> Data {
            return { name in
                var body = Data()
                body.appendString(boundary)
                body.appendString("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n")
                body.appendString("Content-Type: application/octet-stream\r\n\r\n")
                body.appendString("\(String(describing: value.pngData()))\r\n")
                return body
            }
        }
    }
}

extension Data {
    mutating func appendString(_ s: String) {
        self.append(Data(s.utf8))
    }
}
