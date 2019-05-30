//
//  DetailsViewController.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/29/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

let fontSize:CGFloat = 18

class DetailViewController: UIViewController {
    
    convenience init() {
        self.init(id: nil, name: nil, detail: nil, date: nil, rowIndex: nil)
    }
    
    init(id: Int?, name: String?, detail: String?, date: String?, rowIndex:Int?) {
        self.taskId = id
        self.taskName = name
        self.taskDetail = detail
        self.taskDate = date
        self.rowIndex = rowIndex
        super.init(nibName: nil, bundle: nil)
    }
        
    var taskName:String?
    var taskDetail:String?
    var taskDate:String?
    var rowIndex:Int?
    var taskId:Int?
    
    let height:CGFloat = UIScreen.main.bounds.height * 0.5
    let width = UIScreen.main.bounds.width - 40
    let centerY:CGFloat = 20
    let totalHeight = UIScreen.main.bounds.height
    
    let modalView = ModalView()
    let addTaskView = AddTaskView()
    
    static let shared = DetailViewController()
    
    var taskNameLabel:UILabel = UILabel().labelCreator(id: 001, text: "tarea", textColor: .black, textAlignment: .center, fontSize: fontSize)
    var taskDetailLabel:UILabel?  = UILabel().labelCreator(id: 002, text: "descripción", textColor: .black, textAlignment: .center, fontSize: fontSize)
    var taskDateLabel:UILabel?  = UILabel().labelCreator(id: 003, text: "fecha", textColor: .black, textAlignment: .center, fontSize: fontSize)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
        viewDetails()
    }
    
    func viewDetails(){
        guard let name = taskName, let detail = taskDetail, let date = taskDate  else { return }
        taskNameLabel.text = name
        taskDetailLabel?.text = detail
        taskDateLabel?.text = date
    }
    
    func susbcribeObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: NSNotification.Name("notificationView.updateData"), object: nil)
    }
    
    func setupView(){
        
        view.backgroundColor = UIColor.lightGray
        
        navigationItem.title = "Detail Task View"
        
        view.addSubview(taskNameLabel)
        view.topAutoAnchors(id: 001, heightPercentage: 0.15, sidePadding: 10, topPadding: 35)
        
        
        view.addSubview(taskDetailLabel!)
        view.AutoAnchors(id: 002, topView: 001, heightPercentage: 0.12, sidePadding: 25, topPadding: 5)
        
        
        view.addSubview(taskDateLabel!)
        view.AutoAnchors(id: 003, topView: 002, heightPercentage: 0.12, sidePadding: 25, topPadding: 5)
        
    }
    
    
    func setupNavBar(){
        
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editBarButtonHandler))
        let trash = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashBarButtonHanlder))
        navigationItem.rightBarButtonItems = [edit, trash]
        
    }
    
    @objc func updateData(){
//        print("notification Data: \(notification)")
        print("notification Data: ")
    }
    
    @objc func trashBarButtonHanlder(){
        print("Trash Bar Button Handler has been triggered")
//        taskNameLabel.text = "jajaja cambio"
        print("El id de la tarea a borrar es: \(self.taskId)")
        
        let alert = UIAlertController(title: "Alerta de Cambio", message: "Estas apunto de borrar la tarea.\n¿Estas seguro?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
            print("Se cancelo la acción")
        }))
        alert.addAction(UIAlertAction(title: "Aceptar", style: .destructive, handler: { (action) in
            print("Se borrarán los datos")
            //Eliminando la tarea de la memoria
            guard let id = self.taskId as? Int, let index = self.rowIndex else { return }
            ViewController.shared.deleteRecord(id: id)
            TableViewDelegate.shared.tareas.remove(at: index)
        
            //Regresando a las tareas
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func editBarButtonHandler(){
        print("Edit Bar Button Handler has been triggered")
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(modalView)
            modalView.frame = view.frame
            
            window.addSubview(addTaskView)
            self.addTaskView.frame = CGRect(x: centerY, y: totalHeight, width: width, height: height)
            print("view height: \(UIScreen.main.bounds.height) taskView height: \(self.addTaskView.frame.size.height)")
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.modalView.alpha = 1
                self.addTaskView.frame = CGRect(x: self.centerY, y: (self.totalHeight - self.height)/2, width: self.addTaskView.frame.width, height: self.addTaskView.frame.height)
            }, completion: nil)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
            modalView.addGestureRecognizer(tap)
        }
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
    }
    
    @objc func tapHandler(){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.addTaskView.frame = CGRect(x: self.centerY, y: self.totalHeight, width: self.width, height: self.height)
        }, completion: { (Bool) in
            self.modalView.removeFromSuperview()
            self.addTaskView.removeFromSuperview()
        })
        
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
}

//extension DetailViewController: tasksDisplayer {
//
//    //Configuramos los datos de la vista para mostrar
//    //MARK:- displayTaskDetails
//    func displayTaskDetails(id:Int, name: String, detail: String, date: String) {
//        print("displayTaskDetails")
////        print("task name from view: \(name) \ntask detail from view: \(detail)")
//        self.taskId = id
//        taskNameLabel.text = "cambia el text"
//    }
//
//}
