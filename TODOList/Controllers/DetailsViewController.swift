//
//  DetailsViewController.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/29/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

let fontSize:CGFloat = 18

class DetailViewController: UIViewController, tasksDisplayer {
    
    var taskName:String = "Tarea"
    var taskDetail: String = "Descripción"
    var taskDate: String = "Fecha de realización"
    
    var delegate: tasksDisplayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupView()
        setupNavBar()
        susbcribeObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    func susbcribeObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: NSNotification.Name("notificationView.updateData"), object: nil)
    }
    
    func setupView(){
        
        delegate = self
        
        view.backgroundColor = UIColor.lightGray
        
        navigationItem.title = "Detail Task View"
        
        view.addSubview(UILabel().labelCreator(id: 001, text: self.taskName, textColor: .black, textAlignment: .center, fontSize: fontSize))
        view.topAutoAnchors(id: 001, heightPercentage: 0.15, sidePadding: 10, topPadding: 35)
        
        
        view.addSubview(UILabel().labelCreator(id: 002, text: self.taskDetail, textColor: .black, textAlignment: .center, fontSize: fontSize))
        view.AutoAnchors(id: 002, topView: 001, heightPercentage: 0.12, sidePadding: 25, topPadding: 5)
        
        
        view.addSubview(UILabel().labelCreator(id: 003, text: self.taskDate, textColor: .black, textAlignment: .center, fontSize: fontSize))
        view.AutoAnchors(id: 003, topView: 002, heightPercentage: 0.12, sidePadding: 25, topPadding: 5)
        
    }
    
    //Configuramos los datos de la vista para mostrar
    func displayTaskDetails(name: String, detail: String, date: String) {
        print("displayTaskDetails")
        self.taskName = name
        self.taskDetail = detail
        self.taskDate = date
        
        print("Comprobación de datos, name: \(self.taskName)")

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
    }
    
    @objc func editBarButtonHandler(){
        print("Edit Bar Button Handler has been triggered")
    }
    
}

protocol tasksDisplayer {
    func displayTaskDetails(name: String, detail:String, date: String)
}
