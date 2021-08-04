//
//  RoutingState.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 30/07/21.
//

import ReSwift

struct RoutingState {
    let navigationState: RoutingDestination
    let imagePicker: ImagePickerProtocol?
    
    init(navigationState: RoutingDestination = .chooseCountry,
         imagePicker: ImagePickerProtocol? = nil) {
        self.navigationState = navigationState
        self.imagePicker = imagePicker
    }
}
