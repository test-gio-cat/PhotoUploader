//
//  ServiceProtocol.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 04/08/21.
//

import Foundation
import Combine

protocol ServiceProtocol {
    func get<D: Decodable>(request: URLRequest) -> AnyPublisher<D, Error>
    func upload(url: String, data: [FormData]) -> AnyPublisher<(String, Double), Error>
}
