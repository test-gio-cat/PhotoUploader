//
//  IndexedTableViewDataSource.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 03/08/21.
//

import UIKit

final class IndexedTableDataSource<V, T> : NSObject, UITableViewDataSource where V: UITableViewCell {
    typealias CellConfiguration = (V, T) -> V

    private let models: [(String, [T])]
    private let configureCell: CellConfiguration
    private let cellIdentifier: String

    init(cellIdentifier: String, models: [(String, [T])], configureCell: @escaping CellConfiguration) {
        self.models = models
        self.cellIdentifier = cellIdentifier
        self.configureCell = configureCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        models.map({ $0.0 })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].1.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? V ?? V()
        let model = models[indexPath.section].1[indexPath.row]
        return configureCell(cell, model)
    }
}

