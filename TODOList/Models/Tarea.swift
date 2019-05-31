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
    
    var id:Int?
    var date: Date?
    var name: String?
    var descripcion: String?
    
    
    init(id:Int?, name: String, descripcion: String, date: Date){
        self.id = id
        self.name = name
        self.descripcion = descripcion
        self.date = date
        
    }
    
}

