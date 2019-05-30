//
//  Task+CoreDataProperties.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/30/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var descripcion: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?

}
