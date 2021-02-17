//
//  UIViewExt.swift
//  goalpost-app
//
//  Created by Artur Zarzecki on 17/02/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit

extension UIView {
    func bindToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double //dictionary about info
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let startingFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue // starting when is below the screen
        // and now we are getting know how far it will go to move up whatever subject we want abouve the keyboard
        let endingFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endingFrame.origin.y - startingFrame.origin.y // how much it moves up
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: KeyframeAnimationOptions.init(rawValue: curve), animations: { self.frame.origin.y += deltaY }, completion: nil)
    }
}
