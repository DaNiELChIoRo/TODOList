//
//  ViewController.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var rowAdderDelegate: rowAdder!
    var taskEditorDelegate: taskEditor!
    
    var tareas = [Task]()
    
    var taskName:String = ""
    var taskDetail: String = ""
    var taskDate: String = ""
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    let dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE d, MMM yyyy h:mm a"
        formatter.locale = Locale(identifier: "es_MX")
        return formatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavBar()
        setupView()
        CoreData()
        records()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sortTasks()
    }

    func setupView() {
        view.backgroundColor = UIColor.white
    }
    
    func setupNavBar() {
        navigationItem.title = "TODO List"
        let rightItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonHandler))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    //MARK:- presentDetailView
    @objc func newView(rowIndex: Int, id: Int64) {

        let detailView = DetailViewController(id: id, name: self.taskName, detail: self.taskDetail, date: self.taskDate, rowIndex: rowIndex)
        detailView.taskEditorDelegate = self
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    @objc func rightBarButtonHandler() {
        print("right action")
        
        let addView = ModalViewController.shared
        addView.rowAdderDelegate = self  
        addView.modalPresentationStyle = .overCurrentContext
        self.present(addView, animated: true)
    }

}

extension ViewController: rowAdder {
    
    func sortTasks(){
        print("the task are about to be sorted!")
        tareas = tareas.sorted { (Task, Task1) -> Bool in
            let date1 = Task.date! as Date
            let date2 = Task1.date! as Date
            //Arregla las fechas de la más proxima a las más lejanas
            if date1 < date2 { return true } else { return false }
        }
        
        tableView.reloadData()
    }
    
    func addRow(tarea: Task) {
        print("rowAdder Delegate fired from ViewController")
        
        tareas.append(tarea)
        
        let indexPath = IndexPath(row: tareas.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        sortTasks()
        
        saveRecord()
        
    }
}

extension ViewController: taskEditor {
    
    func deleteTaskFromMemoryAndView(rowIndex: Int, id: Int64) {
        print("taskEditor deleteTaskFromMemory Delegate fired from ViewController")
        
        tareas.remove(at: rowIndex)
        
        deleteRecord(id: id)
        
        let indexPath = IndexPath(row: rowIndex, section: 0)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func pushTaskToMemoryAndTable(tarea: Tarea, id:Int64) {
        print("taskEditor pushTaskToMemory Delegate fired from ViewController")
        
        updateRecord(id: id, task: tarea)
        
        sortTasks()
        
        var counter:Int = 0
        for task in tareas{
            if task.id == tarea.id {                
                tareas[counter].name = tarea.name
                tareas[counter].descripcion = tarea.descripcion
                tareas[counter].date = tarea.date as NSDate?
            }
            counter += 1
        }

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    
    }
    
}
