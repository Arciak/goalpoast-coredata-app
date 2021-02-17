//
//  UIButtonExt.swift
//  goalpost-app
//
//  Created by Artur Zarzecki on 17/02/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit

extension UIButton {
    func setSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
    }
    
    func setDeselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.7464011312, green: 0.8857318759, blue: 0.7402122021, alpha: 1)
    }
}
