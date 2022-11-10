//
//  MainCoordinator.swift
//  Coding Challenge
//
//  Created by John Lawrence Figuerres on 11/10/22.
//

import Foundation
import UIKit

class MainCoordinator: CoordinatorType {
    var photViewModel: PhotoViewModel
    var albumViewModel: AlbumViewModel
    var subCoordinators: [CoordinatorType] = []
    
    var navigationController: UINavigationController
    init(albumViewModel: AlbumViewModel = AlbumViewModel(),
         photViewModel: PhotoViewModel = PhotoViewModel(),
         subCoordinators: [CoordinatorType] = [],
         navigationController: UINavigationController
    ) {
        self.albumViewModel = albumViewModel
        self.subCoordinators = subCoordinators
        self.navigationController = navigationController
        self.photViewModel = photViewModel
    }
    
    func goToPhotoView(data: AlbumWithUser) {
        let vc = PhotoCollectionViewController.instantiate()
        vc.photoViewModel = photViewModel
        vc.coordinator = self
        vc.selectedAlbum = data
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToPictureViewer(album: AlbumWithUser, photo: Photo) {
        let vc = ImageViewerViewController.instantiate()
        vc.coordinator = self
        vc.selectedAlbum = album
        vc.selectedPhoto = photo
        navigationController.pushViewController(vc, animated: false)
    }
    
    func start() {
        let vc = AlbumTableViewController.instantiate()
        vc.albumViewModel = albumViewModel
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
