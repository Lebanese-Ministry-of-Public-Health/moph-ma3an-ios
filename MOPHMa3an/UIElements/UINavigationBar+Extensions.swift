//
//  UINavigationBar+Extensions.swift
//  TEDMOB
//
//  Created by TEDMOB on 5/22/20.
//  Copyright © 2020 TEDMOB. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    var isTransparent : Bool {
        get {
            return self.shadowImage != nil
        }
        set {
            switch newValue {
            case true :
                self.setBackgroundImage(UIImage(), for: .default)
                self.shadowImage = UIImage()
                
            case false :
                self.shadowImage = nil
                self.setBackgroundImage(nil, for: .default)
            }
        }
    }
    var seperatorIsVisible : Bool {
        get {
            return self.shadowImage != nil
        }
        set {
            switch newValue {
            case false :
                self.shadowImage = UIImage()
                self.setBackgroundImage(UIImage(), for: .default)
            case true :
                self.shadowImage = nil
                self.setBackgroundImage(nil, for: .default)
            }
        }
    }
    
    func applyTransparency (){
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.tintColor = .white//Optional
    }
    
    func applyStyle(appearance : NavigationBarType.NavigationBarAppearance){
        if appearance.backgroundImage != nil {
            if appearance.position != nil {
                self.setBackgroundImage(appearance.backgroundImage,
                                        for: appearance.position!,
                                        barMetrics: appearance.metrics)
            }else{
                self.setBackgroundImage(appearance.backgroundImage,
                                        for: appearance.metrics)
            }
        }
        self.barTintColor = appearance.barTintColor
        self.tintColor = appearance.tintColor
        self.titleTextAttributes = appearance.titleTextAttributes
        self.shadowImage = appearance.shadowImage
        self.clipsToBounds = appearance.shouldClipsToBound
        self.isTranslucent = appearance.isTranslucent
    }
    
    func resetAppearance(){
        
        self.shadowImage = nil
        self.titleTextAttributes = nil
        self.setBackgroundImage(nil, for: .default)
        self.barTintColor = nil
        self.tintColor = nil
    }
    
}

