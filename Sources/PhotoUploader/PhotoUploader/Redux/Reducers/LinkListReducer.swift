//
//  LinkListReducer.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 02/08/21.
//

import ReSwift

func linkListReducer(action: Action, state: LinkListState?) -> LinkListState {
    var state = state ?? LinkListState(links: [])
    switch action {
    case let goToLinkList as GoToLinkList:
        state = .init(links: goToLinkList.list)
    case _ as BackToStart:
        state = .init(links: [])
    default:
        break
    }
    return state
}
