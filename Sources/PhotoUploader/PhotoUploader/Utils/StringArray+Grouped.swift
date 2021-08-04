//
//  StringArray+Grouped.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 03/08/21.
//

import Foundation

extension Array where Element == String {
    var grouped: [(String, [String])] {
        Dictionary(grouping: self) { $0.first.map { String($0) } ?? "" }
            .map({ (letter: $0.key, countries: $0.value.sorted()) })
            .sorted { $0.letter < $1.letter }
    }
}
