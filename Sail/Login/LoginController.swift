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
        }.done { scheme in
            
            let url = URL(string: "\(scheme)://\(address)")!
            let mastodonClient = APIClient(MastodonAPI.Configuration(url))
            
            firstly {
                mastodonClient.request(MastodonAPI.Instance.GetInfo())
            }.then { instance in
                APIClient(HoistAPI.Configuration()).request(HoistAPI.Authentication.GetInstanceInfo(address: address))
                
            }.done { appInfo in
                var request = URLComponents()
                request.path = "/oauth/authorize"
                request.queryItems = [
                    URLQueryItem(name: "responseType", value: "code"),
                    URLQueryItem(name: "clientID", value: appInfo.clientId),
                    URLQueryItem(name: "redirectUri", value: "https://hoist.getsail.app/authentication/authorize"),
                    URLQueryItem(name: "scope", value: "read write follow push"),
                    URLQueryItem(name: "state", value: "{\"address\": \"\(url.absoluteString)\"}")
                ]
                UIApplication.shared.open(request.url(relativeTo: url)!)
                completion(nil)
            }.catch { error in
                switch error {
                case APIError<HoistAPI.RemoteError>.decodingResponse: return completion(.improperResponse)
                case APIError<HoistAPI.RemoteError>.requestFailed: return completion(.requestFailed)
                case APIError<MastodonAPI.RemoteError>.decodingResponse: return completion(.improperResponse)
                case APIError<MastodonAPI.RemoteError>.requestFailed: return completion(.requestFailed)
                default: return completion(.generic)
                }
            }
        }.catch { error in
            return completion(.requestFailed)
        }
        
    }
    
    static func ingestToken(instance: String, token: String) {
        let session = LoginSession(instanceURL: URL(string: instance)!, token: token)
        //SessionStore.sessions[session.uuid] = session
    }

}


enum InstanceConnectError: LocalizedError {
    case requestFailed
    case improperResponse
    case generic
}
