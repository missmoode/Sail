//
//  Account.swift
//  Sail
//
//  Created by Amy Harris on 26/10/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation


struct MAccount: Codable {
    let id: String
    let username: String
    let acct: String
    let displayName: String
    let locked: Bool
    //let createdAt: Date
    let followersCount: Int!
    let followingCount: Int
    let statusesCount: Int
    let note: String
    let url: URL
    let moved: NestWrapper<MAccount>?
    let avatar: URL
    let avatarStatic: URL
    let header: URL
//    let emojis: [Emoji]
    let fields: [MField]?
    let bot: Bool!
    
    let source: MSource?
    
}



struct MSource: Codable {
    let privacy: String?
    let sensitive: Bool?
    let language: String?
    let note: String
    let fields: [MField]
}
