//
//  PhotoUploaderLoadingView.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 02/08/21.
//

import UIKit

class PhotoUploaderLoadingView: UIVisualEffectView {
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var centerView: UIView!
    
    override func awakeFromNib() {
        progressView.progressTintColor = .selection
        progressView.tintColor = .background
        
        titleLabel.textColor = .textCommon
        
        centerView.backgroundColor = .white
        centerView.layer.masksToBounds = true
        centerView.layer.cornerRadius = 15.0
    }
}
