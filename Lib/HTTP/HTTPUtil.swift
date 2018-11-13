//
//  HTTPUtil.swift
//  Sail
//
//  Created by Amy Harris on 02/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import PromiseKit
import UIKit

class HTTPUtil {
    static func schemeFromDomain(_ domain: String) -> Promise<String> {
        return Promise {
            schemeFromDomain(domain, completion: $0.resolve)
        }
    }
    
    static func schemeFromDomain(_ domain: String, completion: @escaping (String?, HTTPError?) -> Void) {
        HTTPRequest(URL(string: "http://\(domain)")!, method: .get).send() { response, data, error in
            if (error != nil) {
                completion(nil, HTTPError.requestFailed)
            }
            else {
                completion((response!.url?.absoluteString.hasPrefix("https"))! ? "https" : "http", nil)
            }
        }
    }
}
