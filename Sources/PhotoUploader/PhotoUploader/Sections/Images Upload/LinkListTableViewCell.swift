//
//  LinkListTableViewCell.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 02/08/21.
//

import UIKit

class LinkListTableViewCell: UITableViewCell {
    @IBOutlet weak var urlContainer: UIView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    static let identifier = "LinkListTableViewCell"
    static let nibName = "LinkListTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        urlContainer.backgroundColor = UIColor.white
        urlContainer.layer.masksToBounds = true
        urlContainer.layer.cornerRadius = 24.0
        
        urlLabel.textColor = UIColor.textCommon
        urlLabel.font = UIFont.medium(ofSize: 16)
        
        icon.image = UIImage(systemName: "doc.on.clipboard")
        icon.tintColor = .textCommon
        
        selectionStyle = .none
        
        contentView.backgroundColor = .background
    }
}
