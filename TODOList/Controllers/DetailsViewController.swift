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
    
    init(id: Int64?, name: String?, detail: String?, date: String?, rowIndex:Int?) {
        self.taskId = id
        self.taskName = name
        self.taskDetail = detail
        self.taskDate = date
        self.rowIndex = rowIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    let height:CGFloat = UIScreen.main.bounds.height * 0.5
    let width = UIScreen.main.bounds.width - 40
    let centerY:CGFloat = 20
    let totalHeight = UIScreen.main.bounds.height
    
    static let shared = DetailViewController()
    
    var taskEditorDelegate: taskEditor?
    
    var taskName:String?
    var taskDetail:String?
    var taskDate:String?
    var rowIndex:Int?
    var taskId:Int64?
    
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
    
    func setupView(){
        
        view.backgroundColor = UIColor.lightGray
        
        navigationItem.title = "Detail Task View"
        
        view.addSubview(taskNameLabel)
        view.topAutoAnchors(id: 001, heightPercentage: 0.15, sidePadding: 25, topPadding: 35)
        
        
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
    
    func taskDeleter(){
        guard let id = self.taskId,
            let index = self.rowIndex
            else { return }
        taskEditorDelegate?.deleteTaskFromMemoryAndView(indexPath: index, id: id)
//            TableView.shared.deleteRecord(at: index)
    }
    
    @objc func trashBarButtonHanlder() {
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
            self.taskDeleter()
        
            //Regresando a la vista principal
//            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func editBarButtonHandler() {
        print("Edit Bar Button Handler has been triggered")
        
        let modalView = ModalViewController.shared
        modalView.modalPresentationStyle = .overCurrentContext
        present(modalView, animated: true)
        
    }
    
}

protocol taskEditor {
    func pushTaskToMemoryAndTable(tarea: Tarea)
    
    func deleteTaskFromMemoryAndView(indexPath: Int, id:Int64)
}

extension DetailViewController: taskEditor {
    
    func deleteTaskFromMemoryAndView(indexPath: Int, id: Int64) {
       
    }

    func pushTaskToMemoryAndTable(tarea: Tarea) {
        
     }
}
