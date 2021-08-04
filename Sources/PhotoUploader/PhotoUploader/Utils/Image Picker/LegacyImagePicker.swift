//
//  LegacyImagePicker.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 01/08/21.
//

import UIKit

class LegacyImagePicker: NSObject, ImagePickerProtocol {
    func present(in controller: UIViewController?) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .photoLibrary
        controller?.present(pickerController, animated: true, completion: nil)
    }
    
    func takePhoto(in controller: UIViewController?) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .camera
        controller?.present(pickerController, animated: true, completion: nil)
    }
}

extension LegacyImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo
                                info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        store.dispatch(GoToSelectPhotos())
        guard let image = info[.originalImage] as? UIImage, let data = ImageOptimizator().optimize(image: image, compression: 0.5, resize: 0.3) else {
            store.dispatch(SelectPhotoFailure(error: "Photo not selected"))
            return
        }
        store.dispatch(SelectPhotosAction(photos: [data]))
    }
}

