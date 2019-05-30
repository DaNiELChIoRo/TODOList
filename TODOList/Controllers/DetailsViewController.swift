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
    
    var delegate: tasksDisplayer!
    
    var taskName:String?
    var taskDetail:String?
    var taskDate:String?
    
    var taskNameLabel:UILabel = UILabel().labelCreator(id: 001, text: "tarea", textColor: .black, textAlignment: .center, fontSize: fontSize)
    var taskDetailLabel:UILabel?  = UILabel().labelCreator(id: 002, text: "descripción", textColor: .black, textAlignment: .center, fontSize: fontSize)
    var taskDateLabel:UILabel?  = UILabel().labelCreator(id: 003, text: "fecha", textColor: .black, textAlignment: .center, fontSize: fontSize)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavBar()
//        susbcribeObservers()
        
    }
    
    init(taskName:String, taskDetail:String, taskDate:String) {
        self.taskName = taskName
        self.taskDetail = taskDetail
        self.taskDate = taskDate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func susbcribeObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: NSNotification.Name("notificationView.updateData"), object: nil)
    }
    
    func setupView(){
        TableViewDelegate.shared.delegate = self
        
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
        taskNameLabel.text = "jajaja cambio"
    }
    
    @objc func editBarButtonHandler(){
        print("Edit Bar Button Handler has been triggered")
    }
    
}

extension DetailViewController: tasksDisplayer {
    
    //Configuramos los datos de la vista para mostrar
    //MARK:- displayTaskDetails
    func displayTaskDetails(name: String, detail: String, date: String) {
        print("displayTaskDetails")
//        print("task name from view: \(name) \ntask detail from view: \(detail)")
        taskNameLabel.text = "cambia el text"
    }
    
}
