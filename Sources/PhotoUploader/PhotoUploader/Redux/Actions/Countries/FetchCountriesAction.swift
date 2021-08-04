//
//  FetchCountriesAction.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 30/07/21.
//

import ReSwift
import ReSwiftThunk
import Combine
import Foundation

func fetchCountriesThunk(_ service: CountryServiceProtocol = CountryService()) ->Thunk<AppState> {
    Thunk<AppState> { dispatch, getState in
        guard let state = getState() else { return }
        if state.chooseCountryState.showLoading == false {
            CountryService()
                .getCountries()
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        dispatch(SetCountryErrorAction(error: error.localizedDescription))
                    }
                },
                receiveValue: { dispatch(SetCountriesAction(countries: $0.map({ $0.name }))) })
                .store(in: &cancellables)
            dispatch(FetchCountriesAction())
        }
    }
}

struct FetchCountriesAction: Action {}
