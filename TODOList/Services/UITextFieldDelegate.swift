//
//  UITextFieldDelegate.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/29/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private override init () {}
    
    private let shared = TextFieldDelegate()
    
    let textField = UITextField()
    
    func authorize(){
        textField.delegate = self
    }
    
    
    
}
