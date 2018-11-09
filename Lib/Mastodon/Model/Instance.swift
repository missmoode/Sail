//
//  Instance.swift
//  Sail
//
//  Created by Amy Harris on 02/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
struct MInstance: Decodable {
    
    let uri: URL
    let title: String
    let description: String
    let email: String
    let version: String
    let thumbnail: URL
    let languages: [String]
    let contactAccount: MAccount?
    
    
}

