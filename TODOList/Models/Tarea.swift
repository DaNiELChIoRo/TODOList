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
    var descripcion: String?
    var date: Date?
    
    init(name: String, descripcion: String, date: Date){
        self.name = name
        self.descripcion = descripcion
        self.date = date
    }
    
}

