//
//  MockResponse.swift
//  Coding ChallengeTests
//
//  Created by John Lawrence Figuerres on 11/9/22.
//

import Foundation
import RxSwift

class MockAlbumRepository: AlbumRepositoryType {
    func getAlbumList() -> Single<[AlbumWithUser]> {
       let mockData = Single.just([
        
        AlbumWithUser(album: Album(userId: 1, id: 1, title: "Test Album"),
                      user: User(id: 1,
                                 name: "Test Name",
                                 username: "Test UserName",
                                 address: UserAddress(street: "Test Street",
                                                      suite: "Test Suite",
                                                      city: "Test City",
                                                      zipcode: "12345",
                                                      geo: UserAddressGeo(
                                                        lat: "0",
                                                        lng: "0")),
                                 phone: "091234",
                                 website: "www.test.com",
                                 company: UserCompany(name: "Test Company",
                                                      catchPhrase: "TEST",
                                                      bs: "TEST")
                                )
                     )
    ])
    
       return Single<[AlbumWithUser]>.zip(
            mockData,
            Single<Int>.timer(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance),
            resultSelector: { item, _ in return item }
        )
    }
}

class MockAlbumRepositoryFailedResponse: AlbumRepositoryType {
    func getAlbumList() -> Single<[AlbumWithUser]> {
        return Single<Int>.timer(
            RxTimeInterval.seconds(1),
            scheduler: MainScheduler.instance)
        .flatMap { _ in
            return Single.error(NSError(domain: "Test Error", code: 404))
        }
      
    }
}

class MockPhotoRepository: PhotoRepositoryType {
    func getPhoto(_ albumId: Int) -> Single<[Photo]> {
        let mockData = Single.just([
            Photo(albumId: 1,
                  id: 1,
                  title: "Test Pic",
                  url: "https://via.placeholder.com/600/24f355",
                  thumbnailUrl: "https://via.placeholder.com/150/24f355")
        ])
        
        return Single<[Photo]>.zip(
             mockData,
             Single<Int>.timer(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance),
             resultSelector: { item, _ in return item }
         )
    }
    
   
}

class MockPhotoRepositoryFailedResponse: PhotoRepositoryType {
    func getPhoto(_ albumId: Int) -> Single<[Photo]> {
        return Single<Int>.timer(
            RxTimeInterval.seconds(1),
            scheduler: MainScheduler.instance)
        .flatMap { _ in
            return Single.error(NSError(domain: "Test Error", code: 404))
        }
      
    }
}
