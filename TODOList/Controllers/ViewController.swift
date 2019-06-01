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
    
    var tareas = [Tarea]()
    
    var taskName:String = ""
    var taskDetail: String = ""
    var taskDate: String = ""
    
    let dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MMM/yyyy hh:mm"
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
        DetailViewController.shared.taskEditorDelegate = self
    }
    
    //MARK:- presentDetailView
    @objc func newView(rowIndex: Int, id: Int64) {

        let detailView = DetailViewController(id: id, name: self.taskName, detail: self.taskDetail, date: self.taskDate, rowIndex: rowIndex)
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    @objc func rightBarButtonHandler() {
        print("right action")
       
        
        let addView = ModalViewController.shared
        addView.modalPresentationStyle = .overCurrentContext
        self.present(addView, animated: true)
    }

}

extension ViewController: rowAdder {
    func addRow(tarea: Tarea) {
        print("rowAdder Delegate fired from ViewController")
        
        tareas.append(tarea)
        
        let indexPath = IndexPath(row: tareas.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
}

extension ViewController: taskEditor {
    
    func deleteTaskFromMemoryAndView(indexPath: Int, id: Int64) {
        print("taskEditor deleteTaskFromMemory Delegate fired from ViewController")
        tareas.remove(at: indexPath)
        
        let indexPath = IndexPath(row: indexPath, section: 0)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func pushTaskToMemoryAndTable(tarea: Tarea) {
        print("taskEditor pushTaskToMemory Delegate fired from ViewController")
        
    }
    
}
