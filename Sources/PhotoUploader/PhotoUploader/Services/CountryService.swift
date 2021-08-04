//
//  CountryService.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 30/07/21.
//

import Foundation
import Combine

struct CountryServiceConstants {
    static let baseUrl = "https://api.photoforse.online/geographics"
    static let apiKey = "AIzaSyCccmdkjGe_9Yt-INL2rCJTNgoS4CXsRDc"
}
 
struct CountryService: CountryServiceProtocol {
    let service: ServiceProtocol
    
    init(service: ServiceProtocol = Service()) {
        self.service = service
    }
    
    func getCountries() -> AnyPublisher<[Country], Error> {
        guard let url = URL(string: CountryServiceConstants.baseUrl + "/countries/") else {
            return Fail(error: ServiceError.wrongURL)
                .eraseToAnyPublisher()
        }
        return service
            .get(request: URLRequest(url: url))
    }
}
