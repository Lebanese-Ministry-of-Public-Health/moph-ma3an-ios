//
//  UIFont+Extensions.swift
//  TEDMOB
//
//  Created by TEDMOB on 5/22/20.
//  Copyright © 2020 TEDMOB. All rights reserved.
//

import UIKit

extension UIFont {
    static func regular( _ size : CGFloat) -> UIFont{
        return UIFont(name: "Muli", size: size)!
    }
    static func italic( _ size: CGFloat) -> UIFont {
        return UIFont(name: "Muli-Italic", size: size)!
    }
    static func  light( _ size: CGFloat ) -> UIFont {
        return UIFont(name: "Muli-Light", size: size)!
    }
    static func  bold( _ size: CGFloat) -> UIFont {
        return UIFont(name: "Muli-Bold", size: size)!
    }
}
