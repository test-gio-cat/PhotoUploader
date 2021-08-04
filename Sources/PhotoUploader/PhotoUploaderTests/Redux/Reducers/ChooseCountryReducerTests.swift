//
//  ChooseCountryReducerTests.swift
//  PhotoUploaderTests
//
//  Created by Giovanni Catania on 31/07/21.
//

import XCTest
@testable import PhotoUploader

class ChooseCountryReducerTests: XCTestCase {
    func test_dispatchFetchCountries_reducesLoadingState() {
        let output = chooseCountryReducer(action: FetchCountriesAction(),
                                          state: .init(showLoading: false,
                                                       error: nil,
                                                       countries: [],
                                                       title: "",
                                                       selectedCountry: nil,
                                                       nextStepTitle: "Continue"))
        
        
        XCTAssertEqual(output, .init(showLoading: true,
                                     error: nil,
                                     countries: [],
                                     title: "",
                                     selectedCountry: nil,
                                     nextStepTitle: "Continue"))
    }
    
    func test_dispatchSetCountries_reducesCountriesFetchedState() {
        let output = chooseCountryReducer(action: SetCountriesAction(countries: ["Italy"]),
                                          state: .init(showLoading: false,
                                                       error: nil,
                                                       countries: [],
                                                       title: "",
                                                       selectedCountry: nil,
                                                       nextStepTitle: "Continue"))
        
        XCTAssertEqual(output, .init(showLoading: false,
                                     error: nil,
                                     countries: [("I", ["Italy"])],
                                     title: "Step 1: choose your country",
                                     selectedCountry: nil,
                                     nextStepTitle: "Continue"))
    }
    
    func test_dispatchSetCountriesError_reducesCountriesFetchErrorState() {
        let output = chooseCountryReducer(action: SetCountryErrorAction(error: "Something didn't work"),
                                          state: .init(showLoading: false,
                                                       error: nil,
                                                       countries: [],
                                                       title: "",
                                                       selectedCountry: nil,
                                                       nextStepTitle: "Continue"))
        
        XCTAssertEqual(output, .init(showLoading: false,
                                     error: "Something didn't work",
                                     countries: [],
                                     title: "",
                                     selectedCountry: nil,
                                     nextStepTitle: "Continue"))
    }
    
    func test_dispatchSelectCountry_reducesCountrySelectedState() {
        let output = chooseCountryReducer(action: SelectCountryAction(country: "Italy"),
                                          state: .init(showLoading: false,
                                                       error: nil,
                                                       countries: [("I", ["Italy"]),
                                                                   ("F", ["France"])],
                                                       title: "",
                                                       selectedCountry: nil,
                                                       nextStepTitle: "Continue"))
        
        XCTAssertEqual(output, .init(showLoading: false,
                                     error: nil,
                                     countries: [("I", ["Italy"]),
                                                 ("F", ["France"])],
                                     title: "",
                                     selectedCountry: "Italy",
                                     nextStepTitle: "Continue"))
    }
    
    func test_dispatchSelectCountry_deselectedCountryIfAlreadySelected() {
        let output = chooseCountryReducer(action: SelectCountryAction(country: "Italy"),
                                          state: .init(showLoading: false,
                                                       error: nil,
                                                       countries: [("I", ["Italy"]),
                                                                   ("F", ["France"])],
                                                       title: "",
                                                       selectedCountry: "Italy",
                                                       nextStepTitle: "Continue"))
        
        XCTAssertEqual(output, .init(showLoading: false,
                                     error: nil,
                                     countries: [("I", ["Italy"]),
                                                 ("F", ["France"])],
                                     title: "",
                                     selectedCountry: nil,
                                     nextStepTitle: "Continue"))
    }
    
    func test_chooseCountryReducer_withBackToStart() {
        let input = ChooseCountryState(showLoading: false,
                                       error: nil,
                                       countries: [("I", ["Italy"]),
                                                   ("F", ["France"])],
                                       title: "Step 1: choose your country",
                                       selectedCountry: "Italy",
                                       nextStepTitle: "Continue")
        let output = chooseCountryReducer(action: BackToStart(),
                                          state: input)
        let expected = ChooseCountryState(showLoading: false,
                                          error: nil,
                                          countries: [("I", ["Italy"]),
                                                      ("F", ["France"])],
                                          title: "Step 1: choose your country",
                                          selectedCountry: nil,
                                          nextStepTitle: "Continue")
        XCTAssertEqual(output, expected)
    }
    
    func test_chooseCountryReducer_withInitialNilState() {
        let input: ChooseCountryState? = nil
        let output = chooseCountryReducer(action: BackToStart(),
                                          state: input)
        let expected = ChooseCountryState(showLoading: false,
                                          error: nil,
                                          countries: [],
                                          title: "Step 1: choose your country",
                                          selectedCountry: nil,
                                          nextStepTitle: "Continue")
        XCTAssertEqual(output, expected)
    }
}
