//
//  AppRouter.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 30/07/21.
//

import ReSwift
import UIKit
import PhotosUI
import Combine

enum RoutingDestination: String {
    case chooseCountry = "ChooseCountryViewController"
    case selectPhotos = "SelectPhotosViewController"
    case linkList = "LinkListViewController"
    case pop = "Pop"
    case photoPicker = "PhotoPicker"
    case takePhoto = "TakePhoto"
    case popToRoot = "PopToRoot"
    
    func controllerClass() -> UIViewController.Type {
        switch self {
        case .chooseCountry:
            return ChooseCountryViewController.self
        case .selectPhotos:
            return SelectPhotosViewController.self
        case .linkList:
            return LinkListViewController.self
        case .pop:
            return UIViewController.self
        case .photoPicker:
            return UIViewController.self
        case .takePhoto:
            return UIViewController.self
        case .popToRoot:
            return UIViewController.self
        }
    }
}

final class AppRouter {
    let navigationController: UINavigationController
    
    init(window: UIWindow) {
        navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        window.rootViewController = navigationController
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        
        store.subscribe(self) {
            $0.select {
                $0.routingState
            }
        }
    }
    
    deinit {
        store.unsubscribe(self)
    }
    
    fileprivate func pushViewController<V: UIViewController>(nibName: String, controllerType: V.Type, animated: Bool) {
        let viewController = instantiateViewController(nibName: nibName, type: controllerType)
        if let currentVc = navigationController.topViewController {
            let currentViewControllerType = type(of: currentVc)
            if currentViewControllerType == controllerType {
                return
            }
        }
        
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    private func instantiateViewController<V: UIViewController>(nibName: String, type: V.Type) -> V {
        type.init(nibName: nibName, bundle: Bundle.main)
    }
    
    private func pop() {
        navigationController.popViewController(animated: true)
    }
    
    private func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    private func photoPicker(imagePicker: ImagePickerProtocol?) {
        imagePicker?.present(in: navigationController.topViewController)
    }
    
    private func takePhoto(imagePicker: ImagePickerProtocol?) {
        imagePicker?.takePhoto(in: navigationController.topViewController)
    }
}

extension AppRouter: StoreSubscriber {
    func newState(state: RoutingState) {
        switch state.navigationState {
        case .pop:
            pop()
        case .photoPicker:
            photoPicker(imagePicker: state.imagePicker)
        case .popToRoot:
            popToRoot()
        case .takePhoto:
            takePhoto(imagePicker: state.imagePicker)
        default:
            pushViewController(nibName: state.navigationState.rawValue,
                               controllerType: state.navigationState.controllerClass(),
                               animated: navigationController.topViewController != nil)
        }
    }
}
