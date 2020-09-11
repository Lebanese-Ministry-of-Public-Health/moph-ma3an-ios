//
//  CGFloat+Extensioins.swift
//  TEDMOB
//
//  Created by TEDMOB on 5/21/20.
//  Copyright © 2020 TEDMOB. All rights reserved.
//

import UIKit
extension CGFloat {
    func heightRespectingAspectRatio( _ aspectRatio: CGFloat) -> CGFloat {
        return self / aspectRatio
    }
}
