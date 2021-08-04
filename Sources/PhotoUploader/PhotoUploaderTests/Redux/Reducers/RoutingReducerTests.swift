//
//  RoutingReducerTests.swift
//  PhotoUploaderTests
//
//  Created by Giovanni Catania on 01/08/21.
//

import XCTest
@testable import PhotoUploader

class RoutingReducerTests: XCTestCase {
    func test_routingReducer_withGoToSelectPhotoAndNilState() {
        let input: RoutingState? = nil
        let action = GoToSelectPhotos()
        
        let output = routingReducer(action: action, state: input)
        
        XCTAssertEqual(output.navigationState, .selectPhotos)
        XCTAssertNil(output.imagePicker)
    }
    
    func test_routingReducer_withGoToSelectPhotoAndNotNilInitialState() {
        let input = RoutingState(navigationState: .chooseCountry, imagePicker: MockImagePicker())
        let action = GoToSelectPhotos()
        
        let output = routingReducer(action: action, state: input)
        
        XCTAssertEqual(output.navigationState, .selectPhotos)
        XCTAssertNotNil(output.imagePicker)
    }
    
    func test_routingReducer_withPopAction() {
        let input = RoutingState(navigationState: .chooseCountry, imagePicker: MockImagePicker())
        let action = PopAction()
        
        let output = routingReducer(action: action, state: input)
        
        XCTAssertEqual(output.navigationState, .pop)
        XCTAssertNil(output.imagePicker)
    }
    
    func test_routingReducer_withGoToLibraryPicker() {
        let input = RoutingState(navigationState: .chooseCountry, imagePicker: nil)
        let imagePicker = MockImagePicker()
        let action = GoToLibraryPicker(picker: imagePicker)
        
        let output = routingReducer(action: action, state: input)
        
        XCTAssertEqual(output.navigationState, .photoPicker)
        XCTAssertNotNil(output.imagePicker)
        XCTAssertTrue(output.imagePicker === imagePicker)
    }
    
    func test_routingReducer_withTakePhotoAction() {
        let input = RoutingState(navigationState: .chooseCountry, imagePicker: nil)
        let imagePicker = MockImagePicker()
        let action = TakePhoto(picker: imagePicker)
        
        let output = routingReducer(action: action, state: input)
        XCTAssertEqual(output.navigationState, .takePhoto)
        XCTAssertNotNil(output.imagePicker)
        XCTAssertTrue(output.imagePicker === imagePicker)
    }
    
    func test_routingReducer_withGoToLinkListAction() {
        let input = RoutingState(navigationState: .chooseCountry, imagePicker: MockImagePicker())
        let action = GoToLinkList(list: ["https://catbox.moe/fhjfjfj.jpg"])
        
        let output = routingReducer(action: action, state: input)
        XCTAssertEqual(output.navigationState, .linkList)
        XCTAssertNil(output.imagePicker)
    }
    
    func test_routingReducer_withBackToStart() {
        let input = RoutingState(navigationState: .linkList, imagePicker: MockImagePicker())
        let action = BackToStart()
        
        let output = routingReducer(action: action, state: input)
        XCTAssertEqual(output.navigationState, .popToRoot)
        XCTAssertNil(output.imagePicker)
    }
}
