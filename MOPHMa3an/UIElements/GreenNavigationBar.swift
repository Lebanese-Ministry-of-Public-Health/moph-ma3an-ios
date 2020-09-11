//
//  GreenNavigationBar.swift
//  TEDMOB
//
//  Created by TEDMOB on 5/22/20.
//  Copyright © 2020 TEDMOB. All rights reserved.
//

import Foundation
import UIKit

class BaseNavigationBar : UINavigationBar{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        
        self.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
    }
    
    
}


class GreenNavigationBar: BaseNavigationBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
}

//MARK:- UI
private extension GreenNavigationBar {
    func setUI() {
        self.tintColor = .appGreen
        self.barTintColor = .appGreen
    }
}
