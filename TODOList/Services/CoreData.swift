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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
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
    
    func fetchData() -> [Task]{
        var Tasks = [Task]()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
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
    
    func saveRecord(id: Int64, name: String, description: String, date: Date){
     
        print("Salvando los registros id:\(id), name: \(name), description: \(description), date: \(date) en memoria")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        if let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: context){
            
            let task = NSManagedObject(entity: taskEntity, insertInto: context)
            task.setValue(id, forKey: "id")
            task.setValue(name, forKey: "name")
            task.setValue(description, forKey: "descripcion")
            task.setValue(date, forKey: "date")
            
            do{
                try context.save()
                print("Se han salvado los registros de manera exitosa")
            } catch {
                print("Algo salío mal al intantar guardar los datos")
            }
            
        } else {
            print("error al intentar hacer el parse de la entidad con los datos proporcionados")
        }
        
    }
    
    func deleteRecord(id: Int){
        
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
