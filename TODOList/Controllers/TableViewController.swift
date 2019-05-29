//
//  TableViewController.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit
import Foundation

class TableViewDelegate: UITableViewController {
    
    var taskName:String = ""
    var taskDetail: String = ""
    var taskDate: String = ""
    
    let detailView = DetailViewController()
    
    let tableViewController = UITableViewController()
    
    
    var tareas = [Tarea]()
    
    var delegate: tasksDisplayer!
    
    let dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter
    }()
    
    static let shared = TableViewDelegate()
 
    func records() {
        print("se escribiran las tareas al arreglo")
        
        
        
        let fechaPrimeraTarea:Date = dateFormatter.date(from: "05/06/19") ?? Date.distantFuture
        let tarea = Tarea(name: "Bañar al perro", description: "Bañar al perro en el jardin para que no huela feo", date: fechaPrimeraTarea)
        tareas.append(tarea)
        
        let tarea2 = Tarea(name: "Bañar al gato", description: "Bañar al perro en el jardin para que no huela feo", date: fechaPrimeraTarea)
        tareas.append(tarea2)
        
        let tarea3 = Tarea(name: "Bañarse", description: "Bañarse para que no holer feo", date: fechaPrimeraTarea)
        tareas.append(tarea3)
        
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
        
        let remove = UITableViewRowAction(style: .normal, title: "Remove") { action, index in
            print("remove button tapped of the cell in the positio \(index.row)")
            self.tareas.remove(at: index.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            print(" records: \(self.tareas)")
        }
        remove.backgroundColor = .red
        
        return [remove]
        
    }
    
    //Configurammos la altura de todas las celdas
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tareas.count != 0){
            return 65
        } else {
            return UIScreen.main.bounds.height
        }
    }
    
    //Habilitamos la edición de celdas por el usuario
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Configuramos la acción al seleccionar una celda
    //MARK:- OnRowSelect
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Se ha elegido la hilera: \(indexPath.row)")
        
        NotificationCenter.default.post(name: NSNotification.Name("viewNotification.changeView"), object: nil)
        
        self.taskName = tareas[indexPath.row].name!
        self.taskDetail = tareas[indexPath.row].description!
        self.taskDate = "\(tareas[indexPath.row].date!)"
        
//        NotificationCenter.default.post(name: NSNotification.Name("notificationView.updateData"), object: nil)
        
        print("nombre de la tarea: \(self.taskName)")
        
        delegate?.displayTaskDetails(name: self.taskName, detail: self.taskDetail, date: self.taskDate)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            print("se removera el registro del arreglo en la posición: \(indexPath)" )
            tareas.remove(at: indexPath.row)
        default:
            print("something went the other way")
        }
        
    }
    
}

extension TableViewDelegate: tasksDisplayer{
    func displayTaskDetails(name: String, detail: String, date: String) {
            print("displayTaskDetails that should not be called")
    }
}
