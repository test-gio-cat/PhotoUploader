//
//  UIImage+resize.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 02/08/21.
//

import UIKit

extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage,
                            height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas,
                                       format: format).image {
                                        _ in draw(in: CGRect(origin: .zero, size: canvas))
                                       }
    }
}
