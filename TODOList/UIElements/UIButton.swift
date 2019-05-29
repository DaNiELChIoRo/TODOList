//
//  UIButton.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/29/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func defaultButtonCreator(id:Int, text title:String, color backgroundColor:UIColor, textColor:UIColor, borderRound round:CGFloat, action:Selector) -> UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.addTarget(self, action: action, for: .touchDown)
        button.tintColor = textColor
        button.layer.cornerRadius = round
        button.tag = id
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }
    
}
