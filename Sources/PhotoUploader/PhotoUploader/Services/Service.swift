//
//  Service.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 01/08/21.
//

import Foundation
import Combine
import Alamofire

struct Service: ServiceProtocol {
    func get<D: Decodable>(request: URLRequest) -> AnyPublisher<D, Error> {
        AF.request(request.with(apiKey: CountryServiceConstants.apiKey))
            .publishDecodable(type: D.self)
            .value()
            .mapError({ $0 as Error })
            .eraseToAnyPublisher()
    }
    
    func upload(url: String, data: [FormData]) -> AnyPublisher<(String, Double), Error> {
        let progressSubject = PassthroughSubject<Double, Error>()
        let linkSubject = PassthroughSubject<String, Error>()
        
        AF.upload(multipartFormData: { multipartFormData in
            data.forEach({ multipartFormData.append($0.data,
                                                    withName: $0.name,
                                                    fileName: $0.fileName,
                                                    mimeType: $0.type) })
        }, to: url)
        .uploadProgress(closure: { handler in
            progressSubject.send(handler.fractionCompleted)
            linkSubject.send("")
            if handler.fractionCompleted == 1 {
                progressSubject.send(completion: .finished)
            }
        })
        .publishString()
        .value()
        .mapError({ $0 as Error })
        .sink(receiveCompletion: { linkSubject.send(completion: $0) },
              receiveValue: { linkSubject.send($0) })
        .store(in: &cancellables)
        
        return linkSubject
            .combineLatest(progressSubject)
            .eraseToAnyPublisher()
    }
}

extension URLRequest {
    func with(apiKey: String) -> URLRequest {
        var request = self
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        return request
    }
}
