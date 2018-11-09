//
//  Card.swift
//  Sail
//
//  Created by Amy Harris on 05/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

struct MCard: Codable {
    let id: String
    let title: String
    let description: String
    let image: URL?
    let type: MCardType
    let authorName: String?
    let authorUrl: URL?
    let providerName: String?
    let providerUrl: URL?
    let html: String?
    let width: Int?
    let height: Int?
}
