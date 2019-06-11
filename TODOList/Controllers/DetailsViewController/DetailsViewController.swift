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
    
    let dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE d, MMM yyyy h:mm a"
        formatter.locale = Locale(identifier: "es_MX")
        return formatter
    }()
    
    let height:CGFloat = UIScreen.main.bounds.height * 0.5
    let width = UIScreen.main.bounds.width - 40
    let centerY:CGFloat = 20
    let totalHeight = UIScreen.main.bounds.height
    
    var taskEditorDelegate: taskEditor!
    
    var taskName:String?
    var taskDetail:String?
    var taskDate:String?
    var rowIndex:Int?
    var taskId:Int64?
    
    var taskNameTitle:UILabel? = UILabel().labelCreator(id: 001, text: "Tarea:", backgroundColor: .white, textColor: .black, textStyle: .bold, textAlignment: .center, fontSize: fontSize)
    var taskNameLabel:UILabel? = UILabel().labelCreator(id: 002, text: "tarea", backgroundColor: .lightGray, textColor: .black, textAlignment: .center, fontSize: fontSize)
    var taskDetailTitle:UILabel?  = UILabel().labelCreator(id: 003, text: "Descripción:", backgroundColor: .white, textColor: .black, textStyle: .bold, textAlignment: .center, fontSize: fontSize)
    var taskDetailLabel:UILabel  = UILabel().labelCreator(id: 004, text: "descripción",  backgroundColor: .lightGray, textColor: .black, textAlignment: .center, fontSize: fontSize)
    var taskDateTitle:UILabel?  = UILabel().labelCreator(id: 005, text: "Fecha:", backgroundColor: .white, textColor: .black, textStyle: .bold, textAlignment: .center, fontSize: fontSize)
    var taskDateLabel:UILabel?  = UILabel().labelCreator(id: 006, text: "fecha", backgroundColor: .lightGray, textColor: .black, textAlignment: .center, fontSize: fontSize)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
        viewDetails()
        
    }
    
    func viewDetails() {
        guard let name = taskName, let detail = taskDetail, let date = taskDate  else { return }
        taskNameLabel!.text = name
        taskDetailLabel.text = detail
        taskDateLabel!.text = date
    }
    
    func setupView() {
        view.backgroundColor = UIColor.white
        navigationItem.title = "Detail Task View"
        let heightPercentage:CGFloat = 0.06
        
        view.addSubview(taskNameTitle!)
        view.topAutoAnchors(id: 001, heightPercentage: heightPercentage, sidePadding: 25, topPadding: 35)
        view.addSubview(taskNameLabel!)
        view.AutoAnchors(id: 002, topView: 001, heightPercentage: heightPercentage, sidePadding: 0, topPadding: 5)
        view.addSubview(taskDetailTitle!)
        view.AutoAnchors(id: 003, topView: 002, heightPercentage: heightPercentage, sidePadding: 0, topPadding: 5)
        view.addSubview(taskDetailLabel)
        view.AutoAnchors(id: 004, topView: 003, heightPercentage: heightPercentage, sidePadding: 0, topPadding: 5)
        view.addSubview(taskDateTitle!)
        view.AutoAnchors(id: 005, topView: 004, heightPercentage: heightPercentage, sidePadding: 0, topPadding: 5)
        view.addSubview(taskDateLabel!)
        view.AutoAnchors(id: 006, topView: 005, heightPercentage: heightPercentage, sidePadding: 0, topPadding: 5)
    }
    
    
    func setupNavBar() {        
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(PushModalViewForEditing))
        let trash = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashBarButtonAlertHanlder))
        navigationItem.rightBarButtonItems = [edit, trash]
    }
    
    //MARK:- TASK DELETE
    func taskDeleter() {
        if let id = self.taskId,
            let index = self.rowIndex {
                taskEditorDelegate?.deleteTaskFromMemoryAndView(rowIndex: index, id: id)
        }
    }
    
    @objc func trashBarButtonAlertHanlder() {
        print("Trash Bar Button Handler has been triggered")
        
        let alert = UIAlertController(title: "Alerta de Cambio", message: "Estas apunto de borrar la tarea.\n¿Estas seguro?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
            print("Se cancelo la acción")
        }))
        alert.addAction(UIAlertAction(title: "Aceptar", style: .destructive, handler: { (action) in
            print("Se borrarán los datos")
            //Eliminando la tarea de la memoria
            self.taskDeleter()
        
            //Regresando a la vista principal
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- EDITOR MODAL VIEW PRESENTER
    @objc func PushModalViewForEditing() {
        print("Edit Bar Button Handler has been triggered")
        let modalView = ModalViewController(taskId: taskId, taskName: taskName, taskDetail: taskDetail, taskDate: taskDate)
        modalView.taskView = modalViewEnum.editTask
        modalView.modalPresentationStyle = .overCurrentContext
        modalView.taskEditorDelegate = self
        present(modalView, animated: true)
    }
    
}
