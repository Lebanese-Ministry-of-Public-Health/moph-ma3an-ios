//
//  BaseLabel.swift
//  TEDMOB
//
//  Created by TEDMOB on 5/21/20.
//  Copyright © 2020 TEDMOB. All rights reserved.
//

import UIKit

class BaseLabel: UILabel{
    required
    init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup()
        
    }
    
    override
    init(frame: CGRect){
        super.init(frame: frame)
        self.setup()
    }
    
    private
    func setup(){
        
        self.text = self.text
        self.textColor = self.textColor
        self.font = self.font
        self.layer.display()
    }

}
