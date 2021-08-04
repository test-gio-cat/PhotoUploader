//
//  ChooseCountryState.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 30/07/21.
//

import ReSwift

struct ChooseCountryState: Equatable {
    var showLoading: Bool
    var error: String?
    var countries: [(String, [String])]
    var title: String
    var selectedCountry: String?
    var nextStepTitle: String
    
    static func == (lhs: ChooseCountryState, rhs: ChooseCountryState) -> Bool {
        lhs.showLoading == rhs.showLoading &&
            lhs.error == rhs.error &&
            lhs.countries.map({ $0.1 }) == rhs.countries.map({ $0.1 }) &&
            lhs.countries.map({ $0.0 }) == rhs.countries.map({ $0.0 }) &&
            lhs.title == rhs.title &&
            lhs.selectedCountry == rhs.selectedCountry &&
            lhs.nextStepTitle == rhs.nextStepTitle
    }
}
