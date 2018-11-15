//
//  TimelineMethods.swift
//  Sail
//
//  Created by Amy Harris on 08/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

struct GetHomeTimeline: APIRequest {
    typealias Response = MStatus
    
    static var resourcePath: String {
        return "/api/v1/timelines/home"
    }
    
    static var method: HTTPRequestMethod {
        return .get
    }
}
