//
//  ModalViewExtensions.swift
//  TODOList
//
//  Created by Daniel.Meneses on 6/11/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

extension ModalViewController {
    
    @objc func keyboardWillShow(notification: Notification) {
        print("keyboard will be show!")
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue  {
            if keyboardIsShown == false {
                self.addTaskView?.frame.origin.y -= (keyboardSize.height - (self.view.frame.height/2 - (self.addTaskView?.frame.height)!/2))
                keyboardIsShown = true
            }
        }
    }
    
    @objc func keyboardWillDisapear(notification: Notification) {
        print("keyboard will disappear!")
        if keyboardIsShown == true {
            self.addTaskView?.frame.origin.y = (self.view.frame.height/2 - (self.addTaskView?.frame.height)!/2)
            keyboardIsShown = false
        }
    }
    
}
