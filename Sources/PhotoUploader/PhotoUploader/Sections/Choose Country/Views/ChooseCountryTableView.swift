//
//  ChooseCountryTableView.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 30/07/21.
//

import UIKit

class ChooseCountryTableView: UITableView {
    func setup() {
        register(UINib(nibName: ChooseCountryTableViewCell.nibName,
                       bundle: Bundle.main),
                 forCellReuseIdentifier: ChooseCountryTableViewCell.identifier)
        backgroundColor = UIColor.background
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        sectionIndexColor = .selection
    }
}
