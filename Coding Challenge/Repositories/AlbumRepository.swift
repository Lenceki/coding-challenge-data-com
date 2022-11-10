//
//  AlbumRepository.swift
//  Coding Challenge
//
//  Created by John Lawrence Figuerres on 11/9/22.
//

import Foundation
import RxSwift
import Moya

protocol AlbumRepositoryType  {
    func getAlbumList() -> Single<[AlbumWithUser]>
}

class AlbumRepository: AlbumRepositoryType {
    
    let provider: MoyaProvider<AppAPI>
    
    init(provider: MoyaProvider<AppAPI> = MoyaProvider<AppAPI>()) {
        self.provider = provider
    }
    
    func getAlbumList() -> Single<[AlbumWithUser]> {
        
        let requestAlbum = provider.rx.request(.getAlbum)
            .filterSuccessfulStatusCodes()
            .map([Album].self, using: JSONDecoder(),failsOnEmptyData: true)
        
        let requestUser = self.provider.rx.request(.getUser)
            .filterSuccessfulStatusCodes()
            .map([User].self, using: JSONDecoder(),failsOnEmptyData: true)
        
        return Single.zip(
            requestAlbum,
            requestUser,
            resultSelector: { albumList, userList in
                return albumList.map { album in
                    let user = userList.first { user in
                        return user.id == album.userId
                    }
                    
                    return AlbumWithUser(album: album, user: user)
                }
            }
        )
    }
}
