//
//  TableViewController.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit
import Foundation

//class TableViewDelegate:NSObject, UITableViewDelegate, UITableViewDataSource {
extension ViewController {

 
    //MARK:- escribiendo los registros falsos
    func records() {
        print("se escribiran las tareas al arreglo")
//        let fechaPrimeraTarea:Date = Date()
//        let tarea = Tarea(id: 001, name: "Bañar al perro", descripcion: "Bañar al perro en el jardin para que no huela feo", date: fechaPrimeraTarea)
//        tareas.append(tarea)
//
//        let tarea2 = Tarea(id: 002, name: "Bañar al gato", descripcion: "Bañar al perro en el jardin para que no huela feo", date: fechaPrimeraTarea)
//        tareas.append(tarea2)
//
//        let tarea3 = Tarea(id: 003, name: "Bañarse", descripcion: "Bañarse para que no holer feo", date: fechaPrimeraTarea)
//        tareas.append(tarea3)

        tareas = fetchData()
        
    }
    
    func updateRecods(tarea: Task){
        print("Updating records")
        
        tareas.append(tarea)
        
        print(tareas)
        print("Se ha añadido al arrelo la tarea: \(tareas[tareas.count-1])")
        
        let indexPath = IndexPath(row: tareas.count-1, section: 0)
        
        tableView.insertRows(at: [indexPath], with: .automatic)

        
    }
    
    //Configuramos el numero de celdas por fila
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tareas.count
    }
    
    //Configuramos las celdas que se regresaran por fila
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = CellView(style: .default, reuseIdentifier: "cellView")
        cell.textLabel?.text = tareas[indexPath.row].name
        
        return cell
    }
    
    //Configuramos las acciones que tiene cada hilera
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //MARK:- DELETE ACTION
        let remove = UITableViewRowAction(style: .destructive, title: "Remove") { action, index in
            print("remove button tapped of the cell in the positio \(index.row)")
            self.tareas.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        return [remove]
        
    }
    
    //Habilitamos la edición de celdas por el usuario
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Configuramos la acción al seleccionar una celda
    //#MARK:- OnTap Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Se ha elegido la hilera: \(indexPath.row)")
        
        self.taskName = tareas[indexPath.row].name!
        self.taskDetail = tareas[indexPath.row].descripcion!
        let date = dateFormatter.string(from: tareas[indexPath.row].date! as Date)
        self.taskDate = date
        let id = tareas[indexPath.row].id //else { return }
        
        print("nombre de la tarea: \(self.taskName)")
        
        newView(rowIndex: indexPath.row, id: id)
    }
    
}
