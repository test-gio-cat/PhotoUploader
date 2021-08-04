//
//  PhotoCollectionViewCell.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 31/07/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var onDelete: () -> Void = {}
    
    static let nibName = "PhotoCollectionViewCell"
    static let identifier = "PhotoCollectionViewCell"
    
    override func awakeFromNib() {
        deleteButton.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        deleteButton.tintColor = .deletion
    }
    
    @IBAction func onDelete(_ sender: UIButton) {
        onDelete()
    }
}
