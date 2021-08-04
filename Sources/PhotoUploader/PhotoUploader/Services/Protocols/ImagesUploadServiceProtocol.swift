//
//  ImagesUploadServiceProtocol.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 03/08/21.
//

import UIKit
import Combine

protocol ImagesUploadServiceProtocol {
    func upload(images: [Data]) -> AnyPublisher<Progress, Error>
}
