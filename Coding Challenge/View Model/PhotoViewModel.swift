//
//  PhotoViewModel.swift
//  Coding Challenge
//
//  Created by John Lawrence Figuerres on 11/10/22.
//

import Foundation
import RxSwift

class PhotoViewModel {
    let photoRepo: PhotoRepositoryType
    let isLoading = PublishSubject<Bool>()
    let photoList = PublishSubject<[Photo]>()
    let errorMessage = PublishSubject<String>()
    
    fileprivate let disposeBag = DisposeBag()
    
    init(photoRepo: PhotoRepositoryType = PhotoRepository()) {
        self.photoRepo = photoRepo
    }
    
    func fetchPhotoList(albumId: Int) {
        isLoading.onNext(true)
        photoRepo.getPhoto(albumId).subscribe(onSuccess:  {[weak self] res in
            self?.isLoading.onNext(false)
            self?.photoList.onNext(res)
        }, onFailure: {[weak self]  err  in
            self?.isLoading.onNext(false)
            self?.errorMessage.onNext(err.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
