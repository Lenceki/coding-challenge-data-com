//
//  TestPhotoViewController.swift
//  Coding ChallengeTests
//
//  Created by John Lawrence Figuerres on 11/10/22.
//

import XCTest
import RxBlocking
import RxTest
import RxSwift
import RxCocoa

@testable import Coding_Challenge
final class TestPhotoViewController: XCTestCase {

    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }

    func testGetPhotoList() throws {
       let PhotoViewModel = PhotoViewModel(
        photoRepo: MockPhotoRepository()
        )
        let photoList = scheduler.createObserver([Photo].self)
        let errorMessage = scheduler.createObserver(String.self)
        let isLoading = scheduler.createObserver(Bool.self)
        PhotoViewModel.isLoading.bind(to: isLoading).disposed(by: disposeBag)
        PhotoViewModel.photoList.bind(to: photoList).disposed(by: disposeBag)
        PhotoViewModel.errorMessage.bind(to: errorMessage).disposed(by: disposeBag)
        
        PhotoViewModel.fetchPhotoList(albumId: 1)
        
        XCTAssertEqual(isLoading.events.last, .next(0, true))
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for n seconds")], timeout: 2)
        XCTAssertEqual(isLoading.events.last, .next(0, false))
        
        XCTAssertFalse(photoList.events.isEmpty)
        XCTAssertTrue(errorMessage.events.isEmpty)
     
    }
 
    
    func testGetPhotoListFailed() throws {
       
      let PhotoViewModel = PhotoViewModel(
        photoRepo: MockPhotoRepositoryFailedResponse()
        )
        let photoList = scheduler.createObserver([Photo].self)
        let errorMessage = scheduler.createObserver(String.self)
        let isLoading = scheduler.createObserver(Bool.self)
        PhotoViewModel.isLoading.bind(to: isLoading).disposed(by: disposeBag)
        PhotoViewModel.photoList.bind(to: photoList).disposed(by: disposeBag)
        PhotoViewModel.errorMessage.bind(to: errorMessage).disposed(by: disposeBag)
        
        PhotoViewModel.fetchPhotoList(albumId: 1)
        
        XCTAssertEqual(isLoading.events.last, .next(0, true))
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for n seconds")], timeout: 2)
        XCTAssertEqual(isLoading.events.last, .next(0, false))
        
        XCTAssertTrue(photoList.events.isEmpty)
        XCTAssertFalse(errorMessage.events.isEmpty)
     
    }

}
