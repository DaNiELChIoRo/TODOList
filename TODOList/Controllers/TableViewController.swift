//
//  TableViewController.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit
import Foundation

class TableViewDelegate: UITableViewController, rowAdder {
    func addRow(id: Int64, name: String, detail: String, date: String) {
        print("Alfin!!")
    }
    
    
    var taskName:String = ""
    var taskDetail: String = ""
    var taskDate: String = ""
    
    var rowAddDelegate: rowAdder!
    
    let detailView = DetailViewController()
    
    let tableViewController = UITableViewController()
    
    var tareas = [Task]()
    
    let dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy hh:mm"
        return formatter
    }()
    
    static let shared = TableViewDelegate()
 
    //MARK:- escribiendo los registros falsos
    func records() {
        print("se escribiran las tareas al arreglo")
        tareas = ViewController.shared.fetchData()
//        AddTaskView.shared.rowAdderDelegate = self
    }
    
    func updateRecods(tarea: Task){
        //limpiamos el arreglo de celdas
        tareas.append(tarea)
//        tareas = ViewController.shared.fetchData()
        
        self.tableView.beginUpdates()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.tableView.endUpdates()
        
    
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
        let remove = UITableViewRowAction(style: .normal, title: "Remove") { action, index in
            print("remove button tapped of the cell in the positio \(index.row)")
            ViewController.shared.deleteRecord(id:  Int(self.tareas[indexPath.row].id))
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
    //#MARK:- OnTap Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Se ha elegido la hilera: \(indexPath.row)")
        
        self.taskName = tareas[indexPath.row].name!
        self.taskDetail = tareas[indexPath.row].descripcion!
        self.taskDate = "\(tareas[indexPath.row].date!)"
        let id = Int(tareas[indexPath.row].id)
        
        print("nombre de la tarea: \(self.taskName)")
        
        NotificationCenter.default.post(name: NSNotification.Name("viewNotification.changeView"), object: nil,
                                        userInfo: ["id" : id,
                                                   "name": self.taskName,
                                                   "detail": self.taskDetail,
                                                   "date": self.taskDate,
                                                   "rowIndex": indexPath.row])
        
    }
    
    
}
