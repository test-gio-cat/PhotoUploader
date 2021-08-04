//
//  PhotoUploaderButton.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 31/07/21.
//

import UIKit

class PhotoUploaderButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1 : 0.5
        }
    }
    override func awakeFromNib() {
        backgroundColor = UIColor.selection
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = UIFont.medium(ofSize: 16)
        layer.masksToBounds = true
        layer.cornerRadius = frame.height / 2
    }
}
