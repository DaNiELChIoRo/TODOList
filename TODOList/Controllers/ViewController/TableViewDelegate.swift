//
//  TableViewController.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit
import Foundation

extension ViewController {

    //MARK:- escribiendo los registros falsos
    func records() {
        print("se escribiran las tareas al arreglo")
        let coreData = CoreData(container: self.container)
        tareas = coreData.fetchAllRecords()!
        tableView.register(CellView.self, forCellReuseIdentifier: "cellView")
        presentNoTaskViewVerifyer()
        
    }        
    
    func presentNoTaskViewVerifyer() {
        print("recordChecker function has been called!")
        if tareas.count > 0 {
            sortTasks()
            for v in (navigationController?.view!.subviews)! {
                if(v.isKind(of: NoTasksView.self)) {
                    navigationController?.view.viewWithTag(001)?.removeFromSuperview()
                }
            }
        } else {
            addNoTaskView()
        }
    }
    
    func updateRecods(tarea: Tarea) {
        print("Updating records")
        tareas.append(tarea)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellView", for: indexPath) as! CellView
        cell.name.text = tareas[indexPath.row].name
        let fecha = dateFormatter.string(from: (tareas[indexPath.row].date as Date?)!)
        cell.date.text = fecha
        return cell
    }
    
    //Configuramos las acciones que tiene cada hilera
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //MARK:- DELETE ACTION
        let remove = UITableViewRowAction(style: .destructive, title: "Remove") { action, index in
            print("remove button tapped of the cell in the positio \(index.row)")
            let id = self.tareas[indexPath.row].id!
            self.coreData?.deleteRecord(id: id)
            self.tareas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            UserNotificationService.shared.removeNotification(identifier: String(id))
            self.presentNoTaskViewVerifyer()
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
        let id = tareas[indexPath.row].id!
        print("nombre de la tarea: \(self.taskName), indexPath: \(indexPath.row)")
        newView(rowIndex: indexPath.row, id: id)
    }
    
}
