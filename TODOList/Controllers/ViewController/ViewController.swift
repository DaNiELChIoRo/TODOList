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

protocol CoreDataContainer {
    var container: NSPersistentContainer { get }
}

extension UIViewController: CoreDataContainer {
    var container: NSPersistentContainer {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
}

class ViewController: UITableViewController {
    
    var rowAdderDelegate: rowAdder!
    var taskEditorDelegate: taskEditor!
    
    var tareas = [Tarea]()
    
    var taskName:String = ""
    var taskDetail: String = ""
    var taskDate: String = ""
    
    var vista:NoTasksView?
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var coreData: CoreData?
    
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
        records()
        requestPermisions() 
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recordChecker()        
    }

    fileprivate func setupView() {
        view.backgroundColor = UIColor.white
        coreData = CoreData(container: self.container)
    }
    
    //MARK:- Application Permisions Setup
    fileprivate func requestPermisions() {
        UserNotificationService.shared.authorize()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "TODO List"
        let rightItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTaskViewBarButtonHandler))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    //MARK:- presentDetailView
    @objc func newView(rowIndex: Int, id: Int64) {
        let detailView = DetailViewController(id: id, name: self.taskName, detail: self.taskDetail, date: self.taskDate, rowIndex: rowIndex)
        detailView.taskEditorDelegate = self
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    @objc func addTaskViewBarButtonHandler() {
        print("addTaskView BarButton action has been triggered")
        let addView = ModalViewController()
        addView.rowAdderDelegate = self
        addView.modalPresentationStyle = .overCurrentContext
        self.present(addView, animated: true)
    }
    
    func addNoTaskView() {
        print("Adding the NoTasksView!")
        let size = UIScreen.main.bounds
        let anotherBarHeight = UIApplication.shared.statusBarFrame.size.height
        guard let barHeight = navigationController?.navigationBar.frame.height else { return }
        vista = NoTasksView(frame: CGRect(x: 0, y: barHeight + anotherBarHeight, width: size.width, height: size.height))
        vista?.tag = 001
        guard vista != nil else { return }
        navigationController?.view.addSubview(vista!)
    }

}

extension ViewController: rowAdder {
    
    func sortTasks() {
        print("the task are about to be sorted!")
        tareas = tareas.sorted { (Task, Task1) -> Bool in
            let date1 = Task.date! as Date
            let date2 = Task1.date! as Date
            //Arregla las fechas de la más proxima a las más lejanas
            if date1 < date2 { return true } else { return false }
        }
        tableView.reloadData()
    }
    
    func addRow(tarea: Tarea) {
        print("rowAdder Delegate fired from ViewController")
        tareas.append(tarea)
        let indexPath = IndexPath(row: tareas.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        coreData?.addTask(tarea.id!, tarea.name!, tarea.descripcion!, tarea.date!)
        recordChecker()
    }
}
