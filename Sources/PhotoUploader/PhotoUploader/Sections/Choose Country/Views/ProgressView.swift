//
//  ProgressView.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 31/07/21.
//

import UIKit

class ProgressView: UIView {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    override var isHidden: Bool {
        didSet {
            activityIndicator?.isHidden = isHidden
        }
    }
}
