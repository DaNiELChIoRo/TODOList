//
//  UIInputText.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

extension UITextField {
    
    func textFliedCreator(id:Int, text title:String, borderColor color: UIColor, textAlignment alignment: NSTextAlignment, fontSize: CGFloat, radius cornerRadius: CGFloat) -> UITextField{
        let textField = UITextField()
        textField.placeholder = title
        textField.textAlignment = alignment
        textField.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: fontSize)
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = color.cgColor
        textField.layer.cornerRadius = cornerRadius
        textField.tag = id
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
}
