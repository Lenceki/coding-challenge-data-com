//
//  ImageViewerViewController.swift
//  Coding Challenge
//
//  Created by John Lawrence Figuerres on 11/10/22.
//

import UIKit
import Kingfisher
class ImageViewerViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    var selectedAlbum: AlbumWithUser?
    var selectedPhoto: Photo?
    
    @IBOutlet weak var photoTittleLabel: UILabel!
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var imageVIew: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedPhoto = selectedPhoto {
            imageVIew.kf.setImage(with: URL(string: selectedPhoto.url))
            imageVIew.enableZoom()
            photoTittleLabel.text = selectedPhoto.title
        }
        
        userNameLabel.text = selectedAlbum?.user?.name
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
