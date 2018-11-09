//
//  Status.swift
//  Sail
//
//  Created by Amy Harris on 26/10/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation


struct MStatus: Fetchable {
    static var fetch: Fetcher = {api, key, completion in
        api.execute(GetAccount(id: key), completionHandler: completion)
    }
    
    let id: String
    let uri: String
    let url: URL?
    let account: MAccount
    let inReplyToId: ForeignKey<MStatus>?
    let inReplyToAccountId: ForeignKey<MAccount>?
    let reblog: NestWrapper<MStatus>?
    let content: String
    let createdAt: Date
    let emojis: [MEmoji]
    let repliesCount: Int
    let reblogsCount: Int
    let favouritesCount: Int
    let reblogged: Bool?
    let favourited: Bool?
    let muted: Bool?
    let sensitive: Bool
    let spoilerText: String
    let visibility: MStatusVisibility
    let mediaAttachments: [MAttachment]
    let mentions: [MMention]
    let tags: [MTag]
    let card: MCard?
    let application: MApplication
    let language: String?
    let pinned: Bool?
}
