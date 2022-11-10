//
//  User.swift
//  Coding Challenge
//
//  Created by John Lawrence Figuerres on 11/9/22.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let address: UserAddress
    let phone: String
    let website: String
    let company: UserCompany
    
    enum CodingKeys: String, CodingKey {
        case id, name, username, address, phone, website, company
    }
}

struct UserAddress: Decodable
{
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: UserAddressGeo
    
    enum CodingKeys: String, CodingKey {
        case street, suite, city, zipcode, geo
    }
}

struct UserAddressGeo: Decodable
{
    let lat: String
    let lng: String
    
    enum CodingKeys: String, CodingKey {
        case lat, lng
    }
}

struct UserCompany: Decodable {
    let name: String
    let catchPhrase: String
    let bs: String
    
    enum CodingKeys: String, CodingKey {
        case name, catchPhrase, bs
    }
}
