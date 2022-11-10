//
//  AlbumViewModel.swift
//  Coding Challenge
//
//  Created by John Lawrence Figuerres on 11/9/22.
//

import Foundation
import RxSwift

class AlbumViewModel {
    let albumRepo: AlbumRepositoryType

    let isLoading = PublishSubject<Bool>()
    let albumList = PublishSubject<[AlbumWithUser]>()
    let errorMessage = PublishSubject<String>()
    fileprivate let disposeBag = DisposeBag()
    
    init(albumRepo: AlbumRepositoryType = AlbumRepository()) {
        self.albumRepo = albumRepo
    }
    
    func fetchGetAlbumList() {
        isLoading.onNext(true)
        albumRepo.getAlbumList().subscribe(onSuccess:  {[weak self] res in
            self?.isLoading.onNext(false)
            self?.albumList.onNext(res)
        }, onFailure: {[weak self]  err  in
            self?.isLoading.onNext(false)
            self?.errorMessage.onNext(err.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
