//
//  ViewControllerTaskEditor.swift
//  TODOList
//
//  Created by Daniel.Meneses on 6/11/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

extension ViewController: taskEditor {
    
    func deleteTaskFromMemoryAndView(rowIndex: Int, id: Int64) {
        print("taskEditor deleteTaskFromMemory Delegate fired from ViewController")        
        coreData?.deleteRecord(id: id)
        removeRecordFromArray(rowIndex: rowIndex)
        recordChecker()
        UserNotificationService.shared.removeNotification(identifier: String(id))
    }
    
    func removeRecordFromArray(rowIndex: Int) {
        tareas.remove(at: rowIndex)
        let indexPath = IndexPath(row: rowIndex, section: 0)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func pushTaskToMemoryAndTable(tarea: Tarea, id:Int64) {
        print("taskEditor pushTaskToMemory Delegate fired from ViewController")
        coreData?.updateRecord(id: id, task: tarea)
        sortTasks()
        updateRecordInArray(tarea: tarea)
    }
    
    func updateRecordInArray(tarea: Tarea) {
        var counter:Int = 0
        for task in tareas{
            if task.id == tarea.id {
                tareas[counter].name = tarea.name
                tareas[counter].descripcion = tarea.descripcion
                tareas[counter].date = tarea.date
            }
            counter += 1
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
