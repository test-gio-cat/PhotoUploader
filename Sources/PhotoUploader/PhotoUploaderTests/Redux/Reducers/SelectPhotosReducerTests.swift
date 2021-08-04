//
//  SelectPhotosReducerTests.swift
//  PhotoUploaderTests
//
//  Created by Giovanni Catania on 01/08/21.
//

import XCTest
@testable import PhotoUploader

class SelectPhotosReducerTests: XCTestCase {
    func test_selectPhotoReduce_withSelectPhotoActionAnd1PhotoSelected() {
        let input = SelectPhotosState(photos: [],
                                      isLoading: false,
                                      nextStepTitle: "",
                                      isUploading: false,
                                      uploadTitle: "",
                                      progress: .empty)
        
        let output = selectPhotosReducer(action: SelectPhotosAction(photos: [Data()]),
                                         state: input)
        let expected = SelectPhotosState(photos: [Data()],
                                         isLoading: false,
                                         nextStepTitle: "Upload 1 photo",
                                         isUploading: false,
                                         uploadTitle: "Upload in progress...",
                                         progress: .empty)
        XCTAssertEqual(output, expected)
    }
    
    func test_selectPhotoReduce_withSelectPhotoActionAnd2PhotosSelected() {
        let input = SelectPhotosState(photos: [Data()],
                                      isLoading: false,
                                      nextStepTitle: "",
                                      isUploading: false,
                                      uploadTitle: "",
                                      progress: .empty)
        
        let output = selectPhotosReducer(action: SelectPhotosAction(photos: [Data(), Data()]),
                                         state: input)
        let expected = SelectPhotosState(photos: [Data(), Data(), Data()],
                                         isLoading: false,
                                         nextStepTitle: "Upload 3 photos",
                                         isUploading: false,
                                         uploadTitle: "Upload in progress...",
                                         progress: .empty)
        XCTAssertEqual(output, expected)
    }
    
    func test_selectPhotosReducer_withLoadingPhotosAction() {
        let input = SelectPhotosState(photos: [Data()],
                                      isLoading: false,
                                      nextStepTitle: "Upload 1 photo",
                                      isUploading: false,
                                      uploadTitle: "Upload in progress...",
                                      progress: .empty)
        
        let output = selectPhotosReducer(action: LoadingPhotosAction(),
                                         state: input)
        let expected = SelectPhotosState(photos: [Data()],
                                         isLoading: true,
                                         nextStepTitle: "Upload 1 photo",
                                         isUploading: false,
                                         uploadTitle: "Upload in progress...",
                                         progress: .empty)
        XCTAssertEqual(output, expected)
    }
    
    func test_selectPhotosReducer_withDeletePhotoAction() {
        let input = SelectPhotosState(photos: [Data()],
                                      isLoading: false,
                                      nextStepTitle: "Upload 1 photo",
                                      isUploading: false,
                                      uploadTitle: "Upload in progress...",
                                      progress: .empty)
        
        let output = selectPhotosReducer(action: DeletePhotoAction(photo: Data()),
                                         state: input)
        let expected = SelectPhotosState(photos: [],
                                         isLoading: false,
                                         nextStepTitle: "Upload",
                                         isUploading: false,
                                         uploadTitle: "Upload in progress...",
                                         progress: .empty)
        XCTAssertEqual(output, expected)
    }
    
    func test_selectPhotosReducer_withNilInitialState_andDeletePhotoAction() {
        let input: SelectPhotosState? = nil
        
        let output = selectPhotosReducer(action: DeletePhotoAction(photo: Data()),
                                         state: input)
        let expected = SelectPhotosState(photos: [],
                                         isLoading: false,
                                         nextStepTitle: "Upload",
                                         isUploading: false,
                                         uploadTitle: "Upload in progress...",
                                         progress: .empty)
        XCTAssertEqual(output, expected)
    }
    
    func test_selectPhotosReducer_withUploadInProgressActionStarted() {
        let input = SelectPhotosState(photos: [Data()],
                                      isLoading: false,
                                      nextStepTitle: "Upload 1 photo",
                                      isUploading: false,
                                      uploadTitle: "Upload in progress...",
                                      progress: .empty)
        let output = selectPhotosReducer(action: UploadInProgress(progress: .init(percentage: 0.5,
                                                                                  completed: 0,
                                                                                  links: [])),
                                         state: input)
        let expected = SelectPhotosState(photos: [Data()],
                                         isLoading: false,
                                         nextStepTitle: "Upload 1 photo",
                                         isUploading: true,
                                         uploadTitle: "0 files uploaded...",
                                         progress: .init(percentage: 0.5,
                                                         completed: 0,
                                                         links: []))
        XCTAssertEqual(output, expected)
    }
    
    func test_selectPhotosReducer_withUploadInProgressActionFinished() {
        let input = SelectPhotosState(photos: [Data()],
                                      isLoading: false,
                                      nextStepTitle: "Upload 1 photo",
                                      isUploading: false,
                                      uploadTitle: "Upload in progress...",
                                      progress: .empty)
        let output = selectPhotosReducer(action: UploadInProgress(progress: .init(percentage: 1.0,
                                                                                  completed: 1,
                                                                                  links: ["http://catbox.moe/yryr.jpg"])),
                                         state: input)
        let expected = SelectPhotosState(photos: [Data()],
                                         isLoading: false,
                                         nextStepTitle: "Upload 1 photo",
                                         isUploading: true,
                                         uploadTitle: "Generating URLs...",
                                         progress: .init(percentage: 1.0,
                                                         completed: 1,
                                                         links: ["http://catbox.moe/yryr.jpg"]))
        XCTAssertEqual(output, expected)
    }
    
    func test_selectPhotosReducer_withUploadActionFailure() {
        let input = SelectPhotosState(photos: [Data(), Data()],
                                      isLoading: false,
                                      nextStepTitle: "Upload 2 photo",
                                      isUploading: true,
                                      uploadTitle: "Upload in progress...",
                                      progress: .init(percentage: 0.76,
                                                      completed: 1,
                                                      links: ["http://catbox.moe/yryr.jpg"]))
        let output = selectPhotosReducer(action: UploadActionFailure(error: "API error"),
                                         state: input)
        let expected = SelectPhotosState(photos: [Data(), Data()],
                                         isLoading: false,
                                         nextStepTitle: "Upload 2 photo",
                                         isUploading: false,
                                         uploadTitle: "Upload in progress...",
                                         uploadError: "API error",
                                         progress: .init(percentage: 0.76,
                                                         completed: 1,
                                                         links: ["http://catbox.moe/yryr.jpg"]))
        XCTAssertEqual(output, expected)
    }
    
    func test_selectPhotosReducer_withBackToStart() {
        let input = SelectPhotosState(photos: [Data(), Data()],
                                      isLoading: false,
                                      nextStepTitle: "Upload 2 photo",
                                      isUploading: true,
                                      uploadTitle: "Upload in progress...",
                                      progress: .init(percentage: 0.76,
                                                      completed: 1,
                                                      links: ["http://catbox.moe/yryr.jpg"]))
        let output = selectPhotosReducer(action: BackToStart(),
                                         state: input)
        let expected = SelectPhotosState(photos: [],
                                         isLoading: false,
                                         nextStepTitle: "Upload",
                                         isUploading: false,
                                         uploadTitle: "Upload in progress...",
                                         progress: .empty)
        XCTAssertEqual(output, expected)
    }
    
    func test_selectPhotosReducer_withSelectPhotoFailure() {
        let input = SelectPhotosState(photos: [Data(), Data()],
                                      isLoading: true,
                                      nextStepTitle: "Upload 2 photos",
                                      isUploading: false,
                                      uploadTitle: "Upload in progress...",
                                      progress: .init(percentage: 0.76,
                                                      completed: 1,
                                                      links: ["http://catbox.moe/yryr.jpg"]))
        let output = selectPhotosReducer(action: SelectPhotoFailure(error: "Photo select error"),
                                         state: input)
        let expected = SelectPhotosState(photos: [Data(), Data()],
                                         isLoading: false,
                                         nextStepTitle: "Upload 2 photos",
                                         isUploading: false,
                                         uploadTitle: "Upload in progress...",
                                         progress: .empty,
                                         selectPhotoError: "Photo select error")
        XCTAssertEqual(output, expected)
    }
}
