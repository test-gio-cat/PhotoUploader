//
//  TableViewDataSource.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 30/07/21.
//

import UIKit

final class TableDataSource<V, T> : NSObject, UITableViewDataSource where V: UITableViewCell {
    typealias CellConfiguration = (V, T) -> V
    
    private let models: [T]
    private let configureCell: CellConfiguration
    private let cellIdentifier: String
    
    init(cellIdentifier: String, models: [T], configureCell: @escaping CellConfiguration) {
        self.models = models
        self.cellIdentifier = cellIdentifier
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? V ?? V()
        let model = models[indexPath.row]
        return configureCell(cell, model)
    }
}
