//
//  photo.swift
//  Coding Challenge
//
//  Created by John Lawrence Figuerres on 11/9/22.
//

import Foundation

struct Photo: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String

    
    enum CodingKeys: String, CodingKey {
        case albumId, id, title, url, thumbnailUrl
    }
}
