//
//  Tarea.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import Foundation
import UIKit

struct Tarea {
    var name: String?
    var description: String?
    var date: Date?
    
    init(name: String, description: String, date: Date){
        self.name = name
        self.description = description
        self.date = date
    }
    
}
