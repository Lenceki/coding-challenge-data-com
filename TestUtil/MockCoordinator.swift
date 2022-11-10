//
//  MockCoordinator.swift
//  Coding Challenge
//
//  Created by John Lawrence Figuerres on 11/10/22.
//

import Foundation
import UIKit

let mockCoordinator = MainCoordinator(
    albumViewModel: AlbumViewModel(
        albumRepo: MockAlbumRepository()
    ),
    photViewModel: PhotoViewModel(
        photoRepo: MockPhotoRepository()
    ),
    navigationController: UINavigationController())
