//
//  UITableView.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

extension UILabel {
    
    func labelCreator(id: Int, text title:String, textColor color: UIColor, textAlignment alignment: NSTextAlignment, fontSize: CGFloat) -> UILabel{
        let label = UILabel()
        label.text = title
        label.textColor = color
        label.textAlignment = alignment
        label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: fontSize)
        label.tag = id
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func labelCreator(id: Int, text title:String, backgroundColor: UIColor, textColor color: UIColor, textAlignment alignment: NSTextAlignment, fontSize: CGFloat) -> UILabel{
        let label = UILabel()
        label.text = title
        label.backgroundColor = backgroundColor
        label.textColor = color
        label.textAlignment = alignment
        label.tag = id
        label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
}
