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

class ModalViewController: UIViewController {
    
    static let shared = ModalViewController()
    
    let height:CGFloat = UIScreen.main.bounds.height * 0.5
    let width = UIScreen.main.bounds.width - 40
    let centerY:CGFloat = 20
    let totalHeight = UIScreen.main.bounds.height
    
    let dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    var rowId:Int?
    var taskId:Int64?
    var taskName:String?
    var taskDetail:String?
    var taskDate: String?
    
    var rowAdderDelegate: rowAdder!
  
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
    
    func subscribeToObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(presentAlert), name: NSNotification.Name("modalView.displayAlert"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(createTask), name: NSNotification.Name("modalView.createTask"), object: nil)
    }
    
    func setupView(){
        
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.8)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        view.addGestureRecognizer(tap)
        
        let addTaskView = AddTaskView(frame: CGRect(x: centerY, y: (totalHeight - height)/2, width: width, height: height))
        view.addSubview(addTaskView)
        
    }
    
    //MARK:- Dissmis View
    @objc func tapHandler(){
        
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
    @objc func presentAlert(){
        print("presentAlert Handler hass been trigered!")
        
        let alert = UIAlertController(title: "Mensaje de Alerta", message: "No se han llenado todos los campos", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Entendido", style: .destructive, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK:- PARSING DATA AND CREATING TASK
    @objc func createTask(){
        print("createTask Handler hass been trigered!")
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("modalView.createTask"), object: nil)
        
        print("validación de datos: id: \(taskId), name: \(taskName)")
        
        let id = Int(taskId!)
        let name = taskName!
        let detail = taskDetail!
        let fecha = taskDate!
        let date = dateFormatter.date(from: fecha)!
        
        
        let tarea = Tarea(id: id, name: name, descripcion: detail, date: date)
        
        rowAdderDelegate?.addRow(tarea: tarea)
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.dismiss(animated: true)
        }, completion: nil)
        
    }
    
}

extension ModalViewController: rowAdder {
    func addRow(tarea: Tarea) {
        
    }
}

protocol rowAdder {
    func addRow(tarea: Tarea)
}
