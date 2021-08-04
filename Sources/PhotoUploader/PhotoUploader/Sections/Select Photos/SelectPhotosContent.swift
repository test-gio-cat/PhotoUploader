//
//  SelectPhotosContent.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 31/07/21.
//

import UIKit

class SelectPhotosContent: UIView {
    @IBOutlet weak var photoLibraryButton: PhotoUploaderButton!
    @IBOutlet weak var cameraButton: PhotoUploaderButton!
    @IBOutlet weak var photosCollection: PhotosCollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {        
        backgroundColor = .background
        
        photosCollection.setup()
    }
}
