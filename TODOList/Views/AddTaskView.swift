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

class AddTaskView: UIView {
    
    var rowId:Int?
    
    var rowAdderDelegate: rowAdder!
    
    static let shared = AddTaskView()
    
    let DatePicker:UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        datePicker.addTarget(self, action: #selector(dateFieldHandler), for: .valueChanged)
        return datePicker
    }()
    
    let dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    let fontSize:CGFloat = 18
    
//    let tableView = TableViewDelegate.shared
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    func setupView(){
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10
        
        self.addSubview(UILabel().labelCreator(id: 001, text: "Tarea", textColor: .black, textAlignment: .center, fontSize: fontSize))
        self.topAutoAnchors(id: 001, heightPercentage: 0.15, sidePadding: 10, topPadding: 35)
        
        self.addSubview(UITextField().textFliedCreator(id: 002, text: "Nombre de la tarea", borderColor: .iosBlue, textAlignment: .center, fontSize: fontSize, radius: 8))
        self.AutoAnchors(id: 002, topView: 001, heightPercentage: 0.12, sidePadding: 25, topPadding: 5)
        
        self.addSubview(UILabel().labelCreator(id: 003, text: "Descripción", textColor: .black, textAlignment: .center, fontSize: fontSize))
         self.AutoAnchors(id: 003, topView: 002, heightPercentage: 0.12, sidePadding: 25, topPadding: 5)
        
        self.addSubview(UITextField().textFliedCreator(id: 004, text: "Descripción de la tarea", borderColor: .iosBlue, textAlignment: .center, fontSize: fontSize, radius: 8))
        self.AutoAnchors(id: 004, topView: 003, heightPercentage: 0.12, sidePadding: 25, topPadding: 5)
        
        self.addSubview(UILabel().labelCreator(id: 005, text: "Fecha de realización", textColor: .black, textAlignment: .center, fontSize: fontSize))
        self.AutoAnchors(id: 005, topView: 004, heightPercentage: 0.12, sidePadding: 25, topPadding: 5)
        
        self.addSubview(UITextField().textFliedCreator(id: 006, text: "dd/MM/YYYY", borderColor: .iosBlue, textAlignment: .center, fontSize: fontSize, radius: 8))
        
        let datePicker = self.DatePicker
        
        let dateTextField = self.viewWithTag(006) as! UITextField
        dateTextField.inputView = datePicker
        self.AutoAnchors(id: 006, topView: 005, heightPercentage: 0.1, sidePadding: 25, topPadding: 5)
     
        //Creamos una escucha para cuando se haga tap en la pantalla se pueda deshacer el teclado
        //MARK:- Keyboard dissmisser
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard))
        self.addGestureRecognizer(tap)
        
        self.addSubview(UIButton().defaultButtonCreator(id: 007, text: "Guardar", color: .red, textColor: .white, borderRound: 15, action: #selector(saveButtonHandler)))
        self.AutoAnchors(id: 007, topView: 006, heightPercentage: 0.15, sidePadding: 40, topPadding: 5)
        self.viewWithTag(007)?.topAnchor.constraint(equalTo: (viewWithTag(006)?.bottomAnchor)!, constant: 16).isActive = true
        
    }
    
    //Esta funcion hace que el teclado desaparezca de la vista
    @objc func dissmisKeyboard(){
        self.endEditing(true)
    }
    
    //MARK:- Records SAVE
    @objc func saveButtonHandler(){
        print("saveButtonHandler has been triggered")
        guard let taskName = self.viewWithTag(002) as? UITextField else { return }
        guard let taskDescription = self.viewWithTag(004) as? UITextField else { return }
        guard let taskDate = self.viewWithTag(006) as? UITextField else { return }
        let id = Int64(NSDate().timeIntervalSince1970)
        
        let name = taskName.text
        let description = taskDescription.text
        let date = taskDate.text
        
        taskTextValidator(id: id, name: name!, description: description!, date: date!)
    }
    
    func taskTextValidator(id: Int64, name: String, description:String, date: String){
        
        if name != "", description != "", date != "" {
            guard let fecha = dateFormatter.date(from: date) else { return }
             
            ViewController.shared.saveRecord(id: id, name: name, description: description, date: fecha)
            
            let ide = Int(id)
            
            let tarea = Tarea(id:ide, name: name, descripcion: description, date: fecha)
            
            let viewController = ViewController.shared
            
            viewController.updateRecods(tarea: tarea)

            
            NotificationCenter.default.post(name: NSNotification.Name("viewNotification.removeAddView"), object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("viewNotification.displayAlert"), object: nil)
            
        }
        
    }
    
    @objc func dateFieldHandler(_ sender: UIDatePicker){
        print("Se sea cambiar la fecha")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateTextField = self.viewWithTag(006) as! UITextField
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
}

extension AddTaskView: rowAdder {
    func addRow(id: Int64, name: String, detail: String, date: String){
        print("This is a snippet of code that does not suppost to be called!")
    }
}

protocol rowAdder {
    func addRow(id: Int64, name: String, detail: String, date: String)
}
