//
//  Publishers+CombineLatestMany.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 02/08/21.
//

import Foundation
import Combine

extension Publishers {
    struct CombineLatestMany<Element, F: Error>: Publisher {
        typealias Output = [Element]
        typealias Failure = F
        
        private let upstreams: [AnyPublisher<Element, F>]
        
        init(_ upstreams: [AnyPublisher<Element, F>]) {
            self.upstreams = upstreams
        }
        
        func receive<S: Subscriber>(subscriber: S) where Self.Failure == S.Failure, Self.Output == S.Input {
            let initial = Just<[Element]>([])
                .setFailureType(to: F.self)
                .eraseToAnyPublisher()
            
            let combined = upstreams.reduce(into: initial) { result, upstream in
                result = result.combineLatest(upstream) { elements, element in
                    elements + [element]
                }
                .eraseToAnyPublisher()
            }
            
            combined.subscribe(subscriber)
        }
    }
}
