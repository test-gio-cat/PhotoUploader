//
//  ChooseCountryTableViewCell.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 30/07/21.
//

import UIKit

class ChooseCountryTableViewCell: UITableViewCell {
    @IBOutlet weak var nameContainer: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    static let identifier = "ChooseCountryTableViewCell"
    static let nibName = "ChooseCountryTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameContainer.backgroundColor = UIColor.white
        nameContainer.layer.masksToBounds = true
        nameContainer.layer.cornerRadius = 24.0
        
        nameLabel.textColor = UIColor.textCommon
        nameLabel.font = UIFont.medium(ofSize: 16)
        
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        isSelected ? highlightedStyle() : notHighlightedStyle()
    }
    
    func select(if condition: Bool) {
        condition ? highlightedStyle() : notHighlightedStyle()
    }
    
    private func highlightedStyle() {
        nameContainer.backgroundColor = UIColor.selection
        nameLabel.textColor = UIColor.textSelected
    }
    
    private func notHighlightedStyle() {
        nameContainer.backgroundColor = UIColor.white
        nameLabel.textColor = UIColor.textCommon
    }
}
