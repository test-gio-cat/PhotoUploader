//
//  AppReducer.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 30/07/21.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(routingState: routingReducer(action: action, state: state?.routingState),
                    chooseCountryState: chooseCountryReducer(action: action, state: state?.chooseCountryState),
                    selectPhotosState: selectPhotosReducer(action: action, state: state?.selectPhotosState),
                    linkListState: linkListReducer(action: action, state: state?.linkListState))
}
