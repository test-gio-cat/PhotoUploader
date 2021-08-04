//
//  MockImagePicker.swift
//  PhotoUploaderTests
//
//  Created by Giovanni Catania on 01/08/21.
//

import UIKit
@testable import PhotoUploader

class MockImagePicker: ImagePickerProtocol {
    var presentCallCount: Int = 0
    var takePhotoCallCount: Int = 0
    var presentHandler: (UIViewController?) -> Void = { _ in }
    var takePhotoHandler: (UIViewController?) -> Void = { _ in }
    
    func present(in controller: UIViewController?) {
        presentCallCount += 1
        presentHandler(controller)
    }
    
    func takePhoto(in controller: UIViewController?) {
        takePhotoCallCount += 1
        takePhotoHandler(controller)
    }
}
