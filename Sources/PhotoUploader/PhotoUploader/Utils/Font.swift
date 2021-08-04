//
//  Font.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 30/07/21.
//

import UIKit

extension UIFont {
    static func regular(ofSize size: CGFloat) -> UIFont? {
        UIFont(name: "SlateBook", size: size)
    }
    
    static func medium(ofSize size: CGFloat) -> UIFont? {
        UIFont(name: "Slate-Medium", size: size)
    }
}
