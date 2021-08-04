//
//  ImageOptimizator.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 04/08/21.
//

import UIKit

class ImageOptimizator {
    func optimize(image: UIImage, compression: CGFloat, resize: CGFloat) -> Data? {
        image
            .resized(withPercentage: resize)?
            .jpegData(compressionQuality: compression)
    }
}
