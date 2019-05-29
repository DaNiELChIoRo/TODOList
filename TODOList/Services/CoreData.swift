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
                    print(data.value(forKey: "id")) as! String
                }
            }
        } catch {
            print("Failed")
        }
        
    }
    
    func saveRecord(id: Int, name: String, description: String, date: Date){
     
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
            } catch {
                print("Algo salío mal al intantar guardar los datos")
            }
            
        } else {
            print("error al intentar hacer el parse de la entidad con los datos proporcionados")
        }
        
        
        
        
    }
    
}
