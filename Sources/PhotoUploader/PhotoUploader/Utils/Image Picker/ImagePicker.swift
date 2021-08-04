//
//  ImagePicker.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 01/08/21.
//

import UIKit
import ReSwift
import PhotosUI
import Combine

@available(iOS 14, *)
class ImagePicker: ImagePickerProtocol {
    private var cancellables: [AnyCancellable] = []
    
    func present(in controller: UIViewController?) {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.selectionLimit = 0
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        controller?.present(picker, animated: true, completion: nil)
    }
    
    func takePhoto(in controller: UIViewController?) {}
}

@available(iOS 14, *)
extension ImagePicker: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        store.dispatch(GoToSelectPhotos())
        let itemProviders = results.map(\.itemProvider)
        
        Publishers
            .MergeMany(itemProviders.map({ $0.loadObjectPublisher(ofClass: UIImage.self) }))
            .compactMap({ ImageOptimizator()
                            .optimize(image: $0,
                                      compression: 0.5,
                                      resize: 0.3) })
            .collect()
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .timeout(30.0, scheduler: DispatchQueue.main, customError: { LoadItemError.timeout })
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    store.dispatch(SelectPhotoFailure(error: error.localizedDescription))
                }
            },
            receiveValue: { store.dispatch(SelectPhotosAction(photos: $0)) })
            .store(in: &cancellables)
        store.dispatch(LoadingPhotosAction())
    }
}
