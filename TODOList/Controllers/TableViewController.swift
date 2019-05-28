//
//  TableViewController.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

class TableViewDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private override init() {}
    
    static let shared = TableViewDelegate()
    
    let tableViewController = UITableViewController()
    
    func authorize(){
        
    }
    
    //    var tareas = [String]()
    var tareas = ["Bañar al perro", "Hacer la comida"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tareas.count
    }
    
    //Configuramos las celdas que se regresaran por fila
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = CellView(style: .default, reuseIdentifier: "cellView")
        cell.textLabel?.text = tareas[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let remove = UITableViewRowAction(style: .normal, title: "Remove") { action, index in
            print("remove button tapped of the cell in the positio \(index.row)")
            self.tareas.remove(at: index.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            print(" records: \(self.tareas)")
        }
        remove.backgroundColor = .red
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            print("edit button tapped")
        }
        edit.backgroundColor = .lightGray
        
        return [remove, edit]
        
    }
    
    //Configurammos la altura de todas las celdas
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tareas.count != 0){
            return 65
        } else {
            return UIScreen.main.bounds.height
        }
    }
    
    //Habilitamos la edición de celdas por el usuario
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            print("se removera el registro del arreglo en la posición: \(indexPath)" )
            tareas.remove(at: indexPath.row)
        default:
            print("something went the other way")
        }
        
    }
    
}
