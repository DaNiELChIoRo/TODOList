//
//  UIColorExtension.swift
//  TODOList
//
//  Created by Daniel R Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

public extension UIColor {
    static let iosBlue = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
}

public extension TimeInterval{
    
    func stringFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
        
    }
}
