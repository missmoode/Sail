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
            address = "\(scheme)://\(address)"
            return MastodonAPI.Instance.GetInfo().send(with: GenericAPIRequestGateway(apiURL: URL(address)))
        }.then { instance in
            HoistAPI.Authentication.GetInstanceInfo(address: address).send(with: HoistAPI.APIGateway)
        }.done { appInfo in
            UIApplication.shared.open(MastodonAPI.Oauth.Authorize(clientId: appInfo.clientId, address: address).createHTTPRequest(GenericAPIRequestGateway(apiURL: URL(address)).url))
            completion(nil)
        }.catch { error in
            completion(InstanceConnectError.from(error))
        }
        
    }
    
    static func ingestToken(instance: String, token: String) {
        let session = LoginSession(instanceURL: URL(string: instance)!, token: token)
        SessionStore.sessions[session.uuid] = session
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
