//
//  UIViewControllerExt.swift
//  goalpost-app
//
//  Created by Artur Zarzecki on 17/02/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        // set up own custom transition
        present(viewControllerToPresent, animated: false, completion: nil) // we have overwritten the animation, if we call true it will call a default animation
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
}
