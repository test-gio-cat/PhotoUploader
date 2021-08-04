//
//  LinkListTableView.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 02/08/21.
//

import UIKit

class LinkListTableView: UITableView {
    func setup() {
        register(UINib.init(nibName: LinkListTableViewCell.nibName, bundle: Bundle.main),
                 forCellReuseIdentifier: LinkListTableViewCell.identifier)
        backgroundColor = .background
        separatorStyle = .none
        showsVerticalScrollIndicator = false
    }
}
