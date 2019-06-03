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
        delegateSubscriptions()
        
    }

    func setupView() {
        view.backgroundColor = UIColor.white
    }
    
    func setupNavBar() {
        navigationItem.title = "TODO List"
        let rightItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonHandler))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    func delegateSubscriptions() {
        ModalViewController.shared.rowAdderDelegate = self
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
    func addRow(tarea: Task) {
        print("rowAdder Delegate fired from ViewController")
        
        tareas.append(tarea)
        
        let indexPath = IndexPath(row: tareas.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
}

extension ViewController: taskEditor {
    
    func deleteTaskFromMemoryAndView(indexPath: Int, id: Int64) {
        print("taskEditor deleteTaskFromMemory Delegate fired from ViewController")
        DetailViewController.shared.taskEditorDelegate = self
        tareas.remove(at: indexPath)
        
        let indexPath = IndexPath(row: indexPath, section: 0)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func pushTaskToMemoryAndTable(tarea: Task) {
        print("taskEditor pushTaskToMemory Delegate fired from ViewController")
        var counter:Int = 0
        for task in tareas{
            if task.id == tarea.id{
                tareas.remove(at: counter)
                tareas.insert(tarea, at: counter)
            }
            counter += 1
        }
        
    }
    
}
