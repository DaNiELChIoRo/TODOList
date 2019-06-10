//
//  CoreData.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/29/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import Foundation
import CoreData

class CoreData {
    
    private let container: NSPersistentContainer
    lazy var backgroundContext: NSManagedObjectContext = {
        return container.newBackgroundContext()
    }()
//
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "TODOList")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
//    func CoreData(){
//        let context = persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
//        do {
//            let result = try context.fetch(fetchRequest)
//            if result.count == 0 {
//                print("No existen registros en la base de datos")
//            } else {
//                for data in result as! [NSManagedObject] {
//                    print("tarea id: \(data.value(forKey: "id")!)")
//                    print("nombre de la tarea: \(data.value(forKey: "name")!)")
//                }
//            }
//        } catch {
//            print("Failed")
//        }
//    }
    
    fileprivate func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        } else {
            print("There are no changes to save!")
        }
    }
    
    func addTask(_ id: Int64, _ name:String, _ descripcion: String, _ date: Date) {
        let task = Task(entity: Task.entity(), insertInto: backgroundContext)
        task.id = id
        task.name = name
        task.descripcion = descripcion
        task.date = date as NSDate
        save()
    }
    
    func fetchAllRecords() -> [Tarea]? {
        if let records = fetchAllTasks(){
            let tareas = records.map { (item) -> Tarea in
                let tarea = Tarea(id: item.id, name: item.name!, descripcion: item.descripcion!, date: item.date! as Date)
                return tarea
            }
            return tareas
        } else {
            return nil
        }
    }
    
    fileprivate func fetchAllTasks() -> [Task]? {
        let fetchRequest:NSFetchRequest<Task> = Task.fetchRequest()
        return try! container.viewContext.fetch(fetchRequest)
    }
    
    fileprivate func fetchRecord(id: Int64) -> Task? {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let predicate = NSPredicate(format: "id = $0", "\(id)")
        fetchRequest.predicate = predicate
        do {
            let results = try backgroundContext.fetch(fetchRequest)
            return results[0]
        } catch {
            return nil
        }
    }
    
    func deleteRecord(id: Int64) {
        guard let recordToDelete = fetchRecord(id: id) else { return }
        backgroundContext.delete(recordToDelete)
        save()
    }
    
    func updateRecord(id: Int64, task:Tarea) {
        print("updateRecord method called")
        
        let fetchRequest:NSFetchRequest<Task> = Task.fetchRequest()
        do {
            let results = try container.viewContext.fetch(fetchRequest)
            
            if results.count > 0 {
                let result = results[0]
                result.name = task.name
                result.descripcion = task.descripcion
                result.date = task.date as! NSDate
                save()
            } else {
                print("No existen registros con esa referencia!")
            }
            
        } catch {
            print("Failed do to: \(error)")
        }
        
        
    }
    
//    func createTask(_ id:Int64, _ name: String, _ description:String, _ date: Date) -> Task{
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            let context = appDelegate.persistentContainer.viewContext
//
//            if let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) {
//                let task = Task(entity: entity, insertInto: context)
//
//                task.id = id
//                task.name = name
//                task.descripcion = description
//                task.date = date as? NSDate
//
//                return task
//            }
//        }
//        return Task()
//    }
    
}
