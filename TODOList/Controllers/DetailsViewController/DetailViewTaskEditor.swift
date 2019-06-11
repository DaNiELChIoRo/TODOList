//
//  DetailViewTaskEditor.swift
//  TODOList
//
//  Created by Daniel.Meneses on 6/11/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

protocol taskEditor {
    func pushTaskToMemoryAndTable(tarea: Tarea, id:Int64)
    func deleteTaskFromMemoryAndView(rowIndex: Int, id:Int64)
}

extension DetailViewController: taskEditor {
    
    func deleteTaskFromMemoryAndView(rowIndex: Int, id: Int64) {
        print("deleteTaskFromMemotyAndView method from DetailViewController")
    }
    
    func pushTaskToMemoryAndTable(tarea: Tarea, id:Int64) {
        print("pushTaskToMemoryAndTable method from DetailViewController")
        
        taskNameLabel!.text = tarea.name
        taskDetailLabel!.text = tarea.descripcion
        let date = dateFormatter.string(from: tarea.date! as Date)
        taskDateLabel!.text = date
        if let taskID = self.taskId {
            taskEditorDelegate?.pushTaskToMemoryAndTable(tarea: tarea, id:taskID)
        }
        
    }
}
