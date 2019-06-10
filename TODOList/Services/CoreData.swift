//
//  CoreData.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/29/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension ViewController {
    
    static let shared = ViewController()
    
    func CoreData(){
        if let context = appDelegate?.persistentContainer.viewContext{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
            let result = try context.fetch(fetchRequest)
            if result.count == 0 {
                print("No existen registros en la base de datos")
            } else {
                for data in result as! [NSManagedObject] {
                    print("tarea id: \(data.value(forKey: "id")!)")
                    print("nombre de la tarea: \(data.value(forKey: "name")!)")
                }
            }
        } catch {
            print("Failed")
        }
        }
        
    }
    
    func fetchData() -> [Task]{
        var Tasks = [Task]()
        
        if let context = appDelegate?.persistentContainer.viewContext {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
            
            do {
                let result = try context.fetch(fetchRequest)
                if result.count == 0 {
                    print("No existen registros en la base de datos")
                } else {
                    for data in result as! [Task] {
                        print("tarea id: \(data.value(forKey: "id")!)")
                        print("nombre de la tarea: \(data.value(forKey: "name")!)")
                        Tasks.append(data)
                    }
                }
            } catch {
                print("Failed")
            }
        
        }
        return Tasks
        
    }
    
    func saveRecord(){
       
        if let context = appDelegate?.persistentContainer.viewContext{
        
            do{
                try context.save()
                print("Se han salvado los registros de manera exitosa")
            } catch {
                print("Algo salío mal al intantar guardar los datos")
            }
        }
        
    }
    
    func deleteRecord(id: Int64){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
        
        do {
            let result = try context.fetch(fetchRequest)
            
            if result.count != 0 {
                let objectToDelete = result[0] as!  Task
                context.delete(objectToDelete)
                do {
                    try context.save()
                } catch {
                    print("Error al salvar los cambios, Error: \(error)")
                }
            } else {
                print("No existen registros con esa referencia!")
            }
           
        } catch {
            print("Failed do to: \(error)")
        }
        
    }
    
    func updateRecord(id: Int64, task:Tarea){
        print("updateRecord method called")
  
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
        
        CoreData()
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                let result = results[0]
                result.name = task.name
                result.descripcion = task.descripcion
                result.date = task.date as NSDate?
                do {
                    try context.save()
                } catch {
                    print("Error al salvar los cambios, Error: \(error)")
                }
            } else {
                print("No existen registros con esa referencia!")
            }
            
        } catch {
            print("Failed do to: \(error)")
        }
        
        
    }
    
    func createTask(_ id:Int64, _ name: String, _ description:String, _ date: Date) -> Task{
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            if let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) {
                let task = Task(entity: entity, insertInto: context)
                
                task.id = id
                task.name = name
                task.descripcion = description
                task.date = date as? NSDate
                
                return task
            }
        }
        return Task()
    }
    
}
