//
//  UITextFieldDelegate.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/29/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
   
    override init () {}
    
    static let shared = TextFieldDelegate()
    
    let dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE d, MMM yyyy h:mm a"
        formatter.locale = Locale(identifier: "es_MX")
        return formatter
    }()

    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Se empezara a editar en el campo \(textField.description)")
        let fecha = Date()
        let date = dateFormatter.string(from: fecha)
        textField.text = date
    }
    
}
extension AddTaskView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        datePickerUpdater()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textField Will return")
        let nextTextField = textField.tag + 2
        if let nextResponder = textField.superview?.viewWithTag(nextTextField) {
            if(textField.text == ""){
                if let inputTitle = self.viewWithTag(textField.tag - 1) as? UILabel{
                    if let title = inputTitle.text {
                        inputTitle.text = title+"*"
                    }
                    inputTitle.textColor = UIColor.red
                }
            }
            nextResponder.becomeFirstResponder()
        } else {
            endEditing(true)
        }
            
        return true
    }
    
}

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
