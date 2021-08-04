//
//  CountryHeaderView.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 31/07/21.
//

import UIKit

class PhotoUploaderHeaderView: UIView {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var back: UIButton!
    
    override func awakeFromNib() {
        title.font = UIFont.medium(ofSize: 24)
        title.textColor = UIColor.textCommon
        
        backgroundColor = UIColor.background
        
        back.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        back.tintColor = UIColor.textCommon
    }
}
