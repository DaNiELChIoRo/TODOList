//
//  UIDatePicker.swift
//  TODOList
//
//  Created by Daniel.Meneses on 6/7/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import Foundation
import UIKit

class DatePicker: UIDatePicker {
    
    var funcion:Selector?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupDate() {
        timeZone = NSTimeZone.local
        backgroundColor = UIColor.white
        minimumDate = Date()                       
    }
    
}
