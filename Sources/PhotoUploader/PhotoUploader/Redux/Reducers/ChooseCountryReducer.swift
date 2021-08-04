//
//  ChooseCountryReducer.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 30/07/21.
//

import ReSwift

func chooseCountryReducer(action: Action, state: ChooseCountryState?) -> ChooseCountryState {
    var state = state ?? ChooseCountryState(showLoading: false,
                                            error: nil,
                                            countries: [],
                                            title: "",
                                            selectedCountry: nil,
                                            nextStepTitle: "Continue")
    switch action {
    case _ as FetchCountriesAction:
        state = ChooseCountryState(showLoading: true,
                                   error: nil,
                                   countries: [],
                                   title: "",
                                   selectedCountry: nil,
                                   nextStepTitle: "Continue")
    case let setCountries as SetCountriesAction:
        state = ChooseCountryState(showLoading: false,
                                   error: nil,
                                   countries: setCountries.countries.grouped,
                                   title: "Step 1: choose your country",
                                   selectedCountry: nil,
                                   nextStepTitle: "Continue")
    case let countryError as SetCountryErrorAction:
        state = ChooseCountryState(showLoading: false,
                                   error: countryError.error,
                                   countries: [],
                                   title: "",
                                   selectedCountry: nil,
                                   nextStepTitle: "Continue")
    case let selectCountry as SelectCountryAction:
        state = ChooseCountryState(showLoading: false,
                                   error: nil,
                                   countries: state.countries,
                                   title: state.title,
                                   selectedCountry: selectCountry.country == state.selectedCountry ? nil : selectCountry.country,
                                   nextStepTitle: "Continue")
    case _ as BackToStart:
        state = ChooseCountryState(showLoading: false,
                                   error: nil,
                                   countries: state.countries,
                                   title: "Step 1: choose your country",
                                   selectedCountry: nil,
                                   nextStepTitle: "Continue")
    default:
        break
    }
    return state
}
