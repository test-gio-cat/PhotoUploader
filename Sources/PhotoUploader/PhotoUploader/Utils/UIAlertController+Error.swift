//
//  UIAlertController+Error.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 31/07/21.
//

import UIKit

struct AlertAction {
    let title: String
    let action: () -> Void
}

extension UIAlertController {
    static func showError(message: String,
                          actions: [AlertAction],
                          in view: UIViewController) {
        let controller = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        actions
            .map({ action in UIAlertAction(title: action.title, style: .default, handler: { _ in action.action() }) })
            .forEach({ controller.addAction($0) })
        view.present(controller, animated: true, completion: nil)
    }
}
