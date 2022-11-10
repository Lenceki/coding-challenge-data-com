//
//  PhotoCollectionViewController.swift
//  Coding Challenge
//
//  Created by John Lawrence Figuerres on 11/10/22.
//

import UIKit
import RxSwift
import ProgressHUD
import RxCocoa
import Kingfisher
class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    weak var photoViewModel: PhotoViewModel?
    weak var coordinator: MainCoordinator?
    var selectedAlbum: AlbumWithUser?
    
    let disposeBag = DisposeBag()
    let noOfCellsInRow = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bindViewModel()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let albumId = selectedAlbum?.album.id {
            photoViewModel?.fetchPhotoList(albumId: albumId)
        }
    }
    
    func setupCollectionView() {
        
        self.collectionView.register(UINib(nibName: PhotoCollectionViewCell.typeName, bundle: nil), forCellWithReuseIdentifier: PhotoCollectionViewCell.typeName)
        self.collectionView.delegate = nil
        self.collectionView.dataSource = nil
        self.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Photo.self)
                 .subscribe(onNext: { [weak self] model in
                     guard let selectedAlbum = self?.selectedAlbum else {
                         fatalError("Put value of select album on coordinator")
                     }
                     self?.coordinator?.goToPictureViewer(album: selectedAlbum, photo: model)
                 }).disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        photoViewModel?
            .photoList
            .bind(to: collectionView.rx.items(
                cellIdentifier: PhotoCollectionViewCell.typeName,
                cellType: PhotoCollectionViewCell.self)) {
                    (_, model: Photo, cell: PhotoCollectionViewCell) in
                    
                    let url = URL(string: model.thumbnailUrl)
                    cell.thumbnailImageView.kf.setImage(with: url)
                }.disposed(by: disposeBag)
      
        
        photoViewModel?
            .isLoading
            .subscribe(onNext: {isLoading in
                
            if isLoading {
                ProgressHUD.show()
            } else {
                ProgressHUD.dismiss()
            }
        }).disposed(by: disposeBag)
        
        photoViewModel?
            .errorMessage
            .subscribe(onNext: { [weak self] errorMessage in
                self?.showError(errorMessage)
        }).disposed(by: disposeBag)
        
    }
    

    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

       

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
}
