//
//  Attachment.swift
//  Sail
//
//  Created by Amy Harris on 05/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

struct MAttachment: Codable {
    let id: String
    let type: MAttachmentType
    let url: URL
    let remoteUrl: URL?
    let previewUrl: URL
    let textURL: URL?
    let description: String?
}

enum MAttachmentType: String, Codable {
    case unknown, image, gifv, video
}
