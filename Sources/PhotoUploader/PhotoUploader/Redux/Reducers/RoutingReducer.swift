//
//  RoutingReducer.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 30/07/21.
//

import ReSwift

func routingReducer(action: Action, state: RoutingState?) -> RoutingState {
    var state = state ?? RoutingState()
    switch action {
    case _ as GoToSelectPhotos:
        state = .init(navigationState: .selectPhotos, imagePicker: state.imagePicker)
    case _ as PopAction:
        state = .init(navigationState: .pop)
    case let goToLibrary as GoToLibraryPicker:
        state = .init(navigationState: .photoPicker, imagePicker: goToLibrary.picker)
    case let takePhoto as TakePhoto:
        state = .init(navigationState: .takePhoto, imagePicker: takePhoto.picker)
    case _ as GoToLinkList:
        state = .init(navigationState: .linkList)
    case _ as BackToStart:
        state = .init(navigationState: .popToRoot)
    default:
        break
    }
    return state
}
