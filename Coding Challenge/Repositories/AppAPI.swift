//
//  AppAPI.swift
//  Coding Challenge
//
//  Created by John Lawrence Figuerres on 11/9/22.
//

import Foundation
import Moya

enum AppAPI {
    case getAlbum
    case getUser
    case getPhotos
}

extension AppAPI: TargetType  {
    var baseURL: URL {
        
        guard let envBaseUrl = ProcessInfo.processInfo.environment["api_base_url"],
              let url =  URL(string: envBaseUrl) else {
            fatalError("Invalid base url!")
        }
        return url
    }
    
    var path: String {
        switch self {
            
        case .getAlbum:
            return "albums"
        case .getUser:
            return "users"
        case .getPhotos:
            return "photos"
        }
   
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json; charset=UTF-8"]
    }
    
}

