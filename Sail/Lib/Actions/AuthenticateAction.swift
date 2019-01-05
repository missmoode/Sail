//
//  Session.swift
//  Sail
//
//  Created by Amy Harris on 05/01/2019.
//  Copyright © 2019 Amelia Harris. All rights reserved.
//

import Foundation
import UIKit
import PromiseKit

struct AuthenticateAction: Action {
    let address: String;
    
    func run(_ completion: @escaping (Any?, Error?) -> Void) {
        firstly {
            HTTPUtil.schemeFromDomain(address)
        }.map { scheme in
            URL(string: "\(scheme)://\(self.address)")!
        }.then { url in
            APIClient(HoistAPI.Configuration()).request(HoistAPI.Authentication.GetInstanceInfo(address: url.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)).map { ($0, url) }
        }.done { appInfo, url in
            
            var request = URLComponents()
            request.path = "/oauth/authorize"
            request.queryItems = [
                URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "client_id", value: appInfo.clientId),
                URLQueryItem(name: "redirect_uri", value: "https://hoist.getsail.app/authentication/authorize"),
                URLQueryItem(name: "scope", value: "read write follow push"),
                URLQueryItem(name: "state", value: "{\"address\": \"\(url.absoluteString)\"}")
            ]
            
            completion(nil, nil)
            UIApplication.shared.open(request.url(relativeTo: url)!)
        }.catch { error in
            print(error)
            if let error = (error as? HoistAPI.RemoteError) {
                switch error {
                case .generic(let code, let details):
                    print(code)
                    print(details)
                }
            }
            return completion(nil, error)
        }
    }
}
