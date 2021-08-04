//
//  ImagePickerProtocol.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 01/08/21.
//

import UIKit

protocol ImagePickerProtocol: AnyObject {
    func present(in controller: UIViewController?)
    func takePhoto(in controller: UIViewController?)
}
