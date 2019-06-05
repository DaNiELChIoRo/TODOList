//
//  AddTaskView.swift
//  TODOList
//
//  Created by Daniel R Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import CoreData

enum modalViewEnum{
    case addTask
    case editTask
}

protocol rowAdder {
    func addRow(tarea: Task)
}

class ModalViewController: UIViewController {
    
    static let shared = ModalViewController()
    
    let height:CGFloat = UIScreen.main.bounds.height * 0.5
    let width = UIScreen.main.bounds.width - 40
    let centerY:CGFloat = 20
    let totalHeight = UIScreen.main.bounds.height
    
    var addTaskView:AddTaskView?
    
    let dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE d, MMM yyyy h:mm a"
        formatter.locale = Locale(identifier: "es_MX")
        return formatter
    }()
    
    var rowId:Int?
    var taskId:Int64?
    var taskName:String?
    var taskDetail:String?
    var taskDate: String?
    
    var keyboardIsShown:Bool = false
    
    var taskView:modalViewEnum?
    
    var rowAdderDelegate: rowAdder!
    var taskEditorDelegate: taskEditor!
    
    convenience init(){
        self.init(taskId: nil, taskName:nil, taskDetail:nil, taskDate:nil)
    }
    
    init(taskId:Int64?, taskName: String?, taskDetail:String?, taskDate:String?){
        self.taskId = taskId
        self.taskName = taskName
        self.taskDetail = taskDetail
        self.taskDate = taskDate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        subscribeToObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subscribeToObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("modalView.displayAlert"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("modalView.createTask"), object: nil)
    }
    
    func subscribeToObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(presentAlert), name: NSNotification.Name("modalView.displayAlert"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(createTask(notification:)), name: NSNotification.Name("modalView.createTask"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisapear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupView() {
        
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.8)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        view.addGestureRecognizer(tap)
        
        addTaskView = AddTaskView(frame: CGRect(x: centerY, y: (totalHeight - height)/2, width: width, height: height))
        
        if let id = taskId,
            let name = taskName,
            let detail = taskDetail,
            let date = taskDate {
                addTaskView?.taskView = taskView
                addTaskView?.taskId = id
                addTaskView?.taskNameInput.text = name
                addTaskView?.taskDetailInput.text = detail
                addTaskView?.taskDateInput.text = date
        } else {
            print("the modalView either where called from the ViewController or it haven't get the data!")
        }
        view.addSubview(addTaskView!)
        
    }
    
    //MARK:- Dissmis View
    @objc func tapHandler() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.dismiss(animated: true)
        }, completion: nil)
        
        let addTaskView = AddTaskView.shared
        addTaskView.taskNameInput.text = ""
        addTaskView.taskDetailInput.text = ""
        addTaskView.taskDateInput.text = ""
        

        //TODO algo para enviar la información de regreso a ViewController ....
    }
    
    //MARK:- presentAlert
    @objc func presentAlert() {
        print("presentAlert Handler hass been trigered!")
        
        let alert = UIAlertController(title: "Tarea Vacia", message: "No se han llenado todos los campos", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Entendido", style: .destructive, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK:- PARSING DATA AND CREATING TASK
    @objc func createTask(notification: Notification){
        
        print("createTask Handler hass been trigered!")
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("modalView.createTask"), object: nil)
        
        if let id = notification.userInfo?["id"] as? Int64,
        let name = notification.userInfo?["name"] as? String,
        let detail = notification.userInfo?["description"] as? String,
        let date = notification.userInfo?["date"] as? String {
            
            let fecha = dateFormatter.date(from: date)!
            
            if taskView == modalViewEnum.editTask {
                
                let tarea = Tarea(id: id, name: name, descripcion: detail, date: fecha)
                
                taskEditorDelegate?.pushTaskToMemoryAndTable(tarea: tarea, id:id)
                
            } else {
                
                let tarea = ViewController.shared.createTask(id, name, detail, fecha)
                
                rowAdderDelegate?.addRow(tarea: tarea)
            
            }
            
        } else {
            print("Somethig went wrong while trying to unwrap the date value! Error:")
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.dismiss(animated: true)
        }, completion: nil)
        
    }
    
}

extension ModalViewController: rowAdder {
    func addRow(tarea: Task) {
    }
}
