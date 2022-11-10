//
//  Album.swift
//  Coding Challenge
//
//  Created by John Lawrence Figuerres on 11/9/22.
//

import Foundation

struct Album: Decodable {
    let userId: Int
    let id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
         case userId, id, title
    }
}
