//
//  ConnectService.swift
//  Sail
//
//  Created by Amy Harris on 03/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import PromiseKit
import UIKit

enum LoginControllerEvent: Event {
    case tokenRecieved(token: String)
}

class LoginController {
    static func attemptLogin(address: String, completion: @escaping (InstanceConnectError?) -> Void) {
        
        // Check if the api endpoint for instance info returns the correct data
        
        firstly {
            HTTPUtil.schemeFromDomain(address)
        }.then { scheme in
            MastodonAPIClient("\(scheme)://\(address)").execute(GetInstanceInfo()).map {_ in scheme}
        }.then { scheme in
            APIClient("https://hoist.getsail.app").execute(GetMastodonInfo(address: address)).map {($0, scheme)}
        }.done { (appInfo, scheme) in
            var components = URLComponents()
            components.scheme = scheme
            components.host = address
            components.path = "/oauth/authorize"
            components.queryItems = [
                URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "client_id", value: appInfo.clientId),
                URLQueryItem(name: "redirect_uri", value: "https://hoist.getsail.app/authentication/authorize"),
                URLQueryItem(name: "scope", value: "read write follow push"),
                URLQueryItem(name: "state", value: "{\"scheme\": \"\(scheme)\",\"address\":\"\(address)\"}")
            ]
            UIApplication.shared.open(components.url!)
            completion(nil)
        }.catch { error in
            completion(InstanceConnectError.from(error))
        }
        
    }
    
    static func ingestToken(instance: String, token: String) {
        firstly {
            HTTPUtil.schemeFromDomain(instance)
        }.then { scheme in
            return MastodonAPIClient("\(scheme)://\(instance)", token: token).execute(VerifyCredentials()).map {($0, scheme)}
        }.done { (account, scheme) in
            try AccountManager.addAccount(token: token, instance: AppInstance(name: instance, address: "\(scheme)://\(instance)"), account: account)
        }.catch { error in
            print(error)
        }
     }

}

enum InstanceConnectError: Error {
    case connectionFailure
    case improperResponse
    case generic
    
    static func from(_ error: Error) -> InstanceConnectError {
        switch error {
        case HTTPError.requestFailed:
            return .connectionFailure
        case APIError.decoding: // Couldn't decode to an instance info object, so it's not an instance
            return .improperResponse
        default:
            return .generic
        }
    }
}
