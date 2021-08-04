//
//  CountryServiceProtocol.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 04/08/21.
//

import Foundation
import Combine

protocol CountryServiceProtocol {
    func getCountries() -> AnyPublisher<[Country], Error>
}
