//
//  UIViewController+Toast.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 02/08/21.
//

import UIKit

extension UIViewController {
    func showToast(message : String, font: UIFont?) {
        let toastLabel = UILabel()
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint
            .activate([toastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                       toastLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                       toastLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -180)])
        
        UIView.animate(withDuration: 6.0,
                       delay: 0.1,
                       options: .curveEaseOut,
                       animations: {
                        toastLabel.alpha = 0.0
                       }, completion: {(isCompleted) in
                        toastLabel.removeFromSuperview()
                       })
    } }
