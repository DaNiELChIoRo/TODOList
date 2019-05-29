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
        let attributedText = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: color])
        let textField = UITextField()
        textField.attributedPlaceholder = attributedText
        textField.textAlignment = alignment
        textField.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: fontSize)
        textField.borderStyle = .roundedRect
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = cornerRadius
        textField.layer.borderColor = color.cgColor
        textField.layer.borderWidth = 1.0
        textField.tag = id
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
}
