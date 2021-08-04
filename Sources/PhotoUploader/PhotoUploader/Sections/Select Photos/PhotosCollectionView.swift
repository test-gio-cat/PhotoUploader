//
//  PhotosCollectionView.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 31/07/21.
//

import UIKit

class PhotosCollectionView: UICollectionView {
    func setup() {
        register(UINib.init(nibName: PhotoCollectionViewCell.nibName,
                            bundle: Bundle.main),
                 forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        backgroundColor = .background
        showsVerticalScrollIndicator = false
    }
}
