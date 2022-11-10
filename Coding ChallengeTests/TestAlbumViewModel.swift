//
//  Coding_ChallengeTests.swift
//  Coding ChallengeTests
//
//  Created by John Lawrence Figuerres on 11/9/22.
//

import XCTest
import RxBlocking
import RxTest
import RxSwift
import RxCocoa

@testable import Coding_Challenge

final class TestAlbumViewModel: XCTestCase {
    
 
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }

    func testGetAlbumList() throws {
       let albumViewModel = AlbumViewModel(
            albumRepo: MockAlbumRepository()
        )
        let albumList = scheduler.createObserver([AlbumWithUser].self)
        let errorMessage = scheduler.createObserver(String.self)
        let isLoading = scheduler.createObserver(Bool.self)
        albumViewModel.isLoading.bind(to: isLoading).disposed(by: disposeBag)
        albumViewModel.albumList.bind(to: albumList).disposed(by: disposeBag)
        albumViewModel.errorMessage.bind(to: errorMessage).disposed(by: disposeBag)
        
        albumViewModel.fetchGetAlbumList()
        
        XCTAssertEqual(isLoading.events.last, .next(0, true))
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for n seconds")], timeout: 2)
        XCTAssertEqual(isLoading.events.last, .next(0, false))
        
        XCTAssertFalse(albumList.events.isEmpty)
        XCTAssertTrue(errorMessage.events.isEmpty)
     
    }
 
    
    func testGetAlbumListFailed() throws {
       
      let albumViewModel = AlbumViewModel(
            albumRepo: MockAlbumRepositoryFailedResponse()
        )
        let albumList = scheduler.createObserver([AlbumWithUser].self)
        let errorMessage = scheduler.createObserver(String.self)
        let isLoading = scheduler.createObserver(Bool.self)
        albumViewModel.isLoading.bind(to: isLoading).disposed(by: disposeBag)
        albumViewModel.albumList.bind(to: albumList).disposed(by: disposeBag)
        albumViewModel.errorMessage.bind(to: errorMessage).disposed(by: disposeBag)
        
        albumViewModel.fetchGetAlbumList()
        
        XCTAssertEqual(isLoading.events.last, .next(0, true))
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for n seconds")], timeout: 2)
        XCTAssertEqual(isLoading.events.last, .next(0, false))
        
        XCTAssertTrue(albumList.events.isEmpty)
        XCTAssertFalse(errorMessage.events.isEmpty)
     
    }


}
