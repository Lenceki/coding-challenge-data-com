//
//  PhotoRepository.swift
//  Coding Challenge
//
//  Created by John Lawrence Figuerres on 11/9/22.
//

import Foundation
import RxSwift
import Moya

protocol PhotoRepositoryType {
    func getPhoto(_ albumId: Int) -> Single<[Photo]>
}

class PhotoRepository: PhotoRepositoryType {
    
    let provider: MoyaProvider<AppAPI>
    
    init(provider: MoyaProvider<AppAPI> = MoyaProvider<AppAPI>()) {
        self.provider = provider
    }
    
    func getPhoto(_ albumId: Int) -> Single<[Photo]> {
        return provider.rx.request(.getPhotos)
            .filterSuccessfulStatusCodes()
            .map([Photo].self, using: JSONDecoder(),failsOnEmptyData: true).map {
                $0.filter { photo in
                    photo.albumId == albumId
                }
            }
    }
}
