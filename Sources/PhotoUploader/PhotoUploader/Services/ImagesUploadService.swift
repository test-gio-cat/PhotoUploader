//
//  ImagesUploadService.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 01/08/21.
//

import Foundation
import UIKit
import Combine

struct FormData {
    let name: String
    let data: Data
    let fileName: String?
    let type: String?
}

struct ImagesUploadServiceConstants {
    static let baseUrl = "https://catbox.moe/user/api.php"
    static let requestType = "fileupload"
}

struct ImagesUploadService: ImagesUploadServiceProtocol {
    let service: ServiceProtocol
    
    init(service: ServiceProtocol = Service()) {
        self.service = service
    }
    
    func upload(images: [Data]) -> AnyPublisher<Progress, Error> {
        Publishers
            .CombineLatestMany(images
                                .map({ upload(data: $0) }))
            .map(Progress.init)
            .eraseToAnyPublisher()
    }
    
    private func upload(data: Data) -> AnyPublisher<(String, Double), Error> {
        service
            .upload(url: ImagesUploadServiceConstants.baseUrl,
                    data: [.init(name: "fileToUpload",
                                 data: data,
                                 fileName: "\(UUID().uuidString).jpg",
                                 type: "image/jpeg"),
                           .init(name: "reqtype",
                                 data: Data(ImagesUploadServiceConstants.requestType.utf8),
                                 fileName: nil,
                                 type: "text/plain")
                    ])
    }
}

private extension Progress {
    init(_ progressElement: [(String, Double)]) {
        let percentages = progressElement.map({ $0.1 })
        let links = progressElement.map({ $0.0 }).filter({ !$0.isEmpty })
        let averagePercentage = percentages.reduce(0, +) / Double(percentages.count)
        self.init(percentage: averagePercentage,
                  completed: percentages.filter({ $0 == 1 }).count,
                  links: links)
    }
}
