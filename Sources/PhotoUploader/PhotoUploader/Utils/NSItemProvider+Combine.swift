//
//  NSItemProvider+Combine.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 01/08/21.
//

import Foundation
import Combine

extension NSItemProvider {
    func loadObjectPublisher<T: NSItemProviderReading>(ofClass: T.Type) -> AnyPublisher<T, Error> {
        return Future { promise in
            guard self.canLoadObject(ofClass: T.self) else { promise(.failure(LoadItemError.failed))
                return
            }
            self.loadObject(ofClass: T.self,
                       completionHandler: { object, error in
                        if let error = error {
                            promise(.failure(error))
                            return
                        }
                        if let object = object as? T {
                            promise(.success(object))
                            return
                        }
                        promise(.failure(LoadItemError.failed))
                       })
        }.eraseToAnyPublisher()
    }
}

enum LoadItemError: Error {
    case failed
    case timeout
}
