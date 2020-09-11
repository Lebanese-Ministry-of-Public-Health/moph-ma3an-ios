//
//  RoundedGreenButton.swift
//  TEDMOB
//
//  Created by TEDMOB on 5/21/20.
//  Copyright © 2020 TEDMOB. All rights reserved.
//

import Foundation
import UIKit

class RoundedGreenButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton(){
        self.titleLabel?.font = .bold(15)
        
        self.backgroundColor = .appGreen
        
        self.setTitleColor(.white, for: .normal)
        
        self.layer.cornerRadius = 20
        
    }
}
