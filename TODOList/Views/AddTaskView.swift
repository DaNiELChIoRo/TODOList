//
//  AddTaskView.swift
//  TODOList
//
//  Created by Daniel R Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

class AddTaskView: UIView {
    
    var rowId:Int? = nil ?? 1
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let DatePicker:UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.timeZone = NSTimeZone.local
//        datePicker.datePickerMode = .date
        datePicker.backgroundColor = UIColor.white
        datePicker.addTarget(self, action: #selector(dateFieldHandler), for: .valueChanged)
        return datePicker
    }()
    
    let fontSize:CGFloat = 18
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    func setupView(){
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10
//        self.translatesAutoresizingMaskIntoConstraints = false
        
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let dateTextField = self.viewWithTag(006) as! UITextField
        dateTextField.inputView = datePicker
        self.AutoAnchors(id: 006, topView: 005, heightPercentage: 0.1, sidePadding: 25, topPadding: 5)
     
        //Creamos una escucha para cuando se haga tap en la pantalla se pueda deshacer el teclado
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard))
        self.addGestureRecognizer(tap)
        
        self.addSubview(UIButton().defaultButtonCreator(id: 007, text: "Guardar", color: .red, textColor: .white, borderRound: 15, action: #selector(saveButtonHandler)))
        self.AutoAnchors(id: 007, topView: 006, heightPercentage: 0.15, sidePadding: 40, topPadding: 10)
        
    }
    
    //Esta funcion hace que el teclado desaparezca de la vista
    @objc func dissmisKeyboard(){
        self.endEditing(true)
    }
    
    @objc func saveButtonHandler(){
        print("saveButtonHandler has been triggered")
        guard let taskName = self.viewWithTag(002) as? UITextField else { return }
        guard let taskDescription = self.viewWithTag(004) as? UITextField else { return }
        guard let taskDate = self.viewWithTag(006) as? UITextField else { return }
        guard let id = self.rowId else { return }
        
//        taskTextValidator(id: id ,name: taskName!.text,description: taskDescription?.text, date:taskDate?.text)
    }
    
    func taskTextValidator(id: Int, name: String, description:String, date: String){
        
//        guard let id, name, description, date else {return}
        
//        ViewController.shared.saveRecord(id: <#T##Int#>, name: name, description: description, date: date)
    }
    
    @objc func dateFieldHandler(_ sender: UIDatePicker){
        print("Se sea cambiar la fecha")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateTextField = self.viewWithTag(006) as! UITextField
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
}
