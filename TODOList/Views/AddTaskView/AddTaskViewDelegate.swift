//
//  UITextFieldDelegate.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/29/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit


extension AddTaskView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 006 {
            print("the textInputField is the Date TextField!")
            let fecha = Date()
            let date = dateFormatter.string(from: fecha)
            textField.text = date
            datePickerUpdater()
        }
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textField Will return")
        let nextTextField = textField.tag + 2
        if let nextResponder = textField.superview?.viewWithTag(nextTextField) {
            if(textField.text == "") {
                if let inputTitle = self.viewWithTag(textField.tag - 1) as? UILabel {
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


