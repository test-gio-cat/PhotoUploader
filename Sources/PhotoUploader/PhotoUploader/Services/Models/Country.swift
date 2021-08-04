//
//  Country.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 31/07/21.
//

import Foundation

struct Country: Codable {
    let iso: Int
    let isoAlpha2: String
    let isoAlpha3: String
    let name: String
    let phonePrefix: String
}
