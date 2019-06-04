//
//  AddTaskView.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/31/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit
import UserNotifications


class AddTaskView: UIView {
    
    static let shared = AddTaskView()
    
    let DatePicker:UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(dateFieldHandler), for: .valueChanged)
        return datePicker
    }()
    
    let dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE d, MMM yyyy h:mm a"
        formatter.locale = Locale(identifier: "es_MX")
        return formatter
    }()
    
    var taskNameInput:UITextField = UITextField().textFliedCreator(id: 002, text: "Nombre de la tarea", borderColor: .iosBlue, textAlignment: .center, fontSize: 18, radius: 8)
    var taskDetailInput:UITextField = UITextField().textFliedCreator(id: 004, text: "Descripción de la tarea", borderColor: .iosBlue, textAlignment: .center, fontSize: 18, radius: 8)
    var taskDateInput:UITextField = UITextField().textFliedCreator(id: 006, text: "dd/MMM/yyyy", borderColor: .iosBlue, textAlignment: .center, fontSize: 18, radius: 8)
    
    var taskView:modalViewEnum?
    var taskId:Int64?
    var taskDate:Date?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        backgroundColor = UIColor.white
        layer.cornerRadius = self.frame.height / 12
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard))
        addGestureRecognizer(tap)
        
        self.addSubview(UILabel().labelCreator(id: 001, text: "Tarea", textColor: .black, textAlignment: .center, fontSize: fontSize))
        self.topAutoAnchors(id: 001, heightPercentage: 0.15, sidePadding: 10, topPadding: 15)
        
        self.addSubview(taskNameInput)
        taskNameInput.delegate = self
        self.AutoAnchors(id: 002, topView: 001, heightPercentage: 0.12, sidePadding: 25, topPadding: 5)
        
        self.addSubview(UILabel().labelCreator(id: 003, text: "Descripción", textColor: .black, textAlignment: .center, fontSize: fontSize))
        self.AutoAnchors(id: 003, topView: 002, heightPercentage: 0.12, sidePadding: 25, topPadding: 5)
        
        self.addSubview(taskDetailInput)
        taskDetailInput.delegate = self
        self.AutoAnchors(id: 004, topView: 003, heightPercentage: 0.12, sidePadding: 25, topPadding: 5)
        
        self.addSubview(UILabel().labelCreator(id: 005, text: "Fecha de realización", textColor: .black, textAlignment: .center, fontSize: fontSize))
        self.AutoAnchors(id: 005, topView: 004, heightPercentage: 0.12, sidePadding: 25, topPadding: 5)
        
        self.addSubview(taskDateInput)
        taskDateInput.delegate = TextFieldDelegate.shared
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissmisKeyboard))
        toolbar.setItems([doneButton], animated: true)
        
        let datePicker = DatePicker
        
        let dateTextField = self.viewWithTag(006) as! UITextField
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolbar
        self.AutoAnchors(id: 006, topView: 005, heightPercentage: 0.1, sidePadding: 25, topPadding: 5)
        
        self.addSubview(UIButton().defaultButtonCreator(id: 007, text: "Guardar", color: .red, textColor: .white, borderRound: 15, action: #selector(saveButtonHandler)))
        self.AutoAnchors(id: 007, topView: 006, heightPercentage: 0.12, sidePadding: 40, topPadding: 20)
        
    }
    
    
    @objc func dissmisKeyboard() {
        endEditing(true)
    }
    
    func viewCleaner() {
        taskNameInput.text = ""
        taskDetailInput.text = ""
        taskDateInput.text = ""
    }
    
    fileprivate func createNotification(id: Int64) {
        
        let name = taskNameInput.text!
        let description = taskDetailInput.text!
        let fecha = taskDateInput.text!
        let date = dateFormatter.date(from: fecha)
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date!)
        
        //creamos la notifación apartir de nuestro servicio de notificiaciones
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        UserNotificationService.shared.defaultNotificationRequest(id:id, title: "Recordatorio: \(name)", body: description, sound: .defaultCritical, category: NotificationCategory.date, trigger: trigger)
    }
    
    @objc func dateFieldHandler(_ sender: UIDatePicker) {
        print("Se va a cambiar la fecha")
        let dateTextField = self.viewWithTag(006) as! UITextField
        dateTextField.text = dateFormatter.string(from: sender.date)
        taskDate = sender.date
    }
    
    //MARK:- Task SAVE
    @objc func saveButtonHandler() {
        print("saveButtonHandler has been triggered")
        
        if taskView == modalViewEnum.editTask {
            guard let id = taskId as? Int64 else {
                print("boddy you forgot to pass the task id!")
                return
            }
            let name = taskNameInput.text!
            let description = taskDetailInput.text!
            let date = taskDateInput.text!
            taskTextValidator(id: id, name: name, description: description, date: date)
        } else {
            let id = Int64(NSDate().timeIntervalSince1970)
            let name = taskNameInput.text
            let description = taskDetailInput.text
            let date = taskDateInput.text
            taskTextValidator(id: id, name: name!, description: description!, date: date!)
        }
        
    }
    
    func taskTextValidator(id: Int64, name: String, description:String, date: String){
        print("taskTextValidator has been called!")
        if name != "", description != "", date != "" {
            
            NotificationCenter.default.post(name: NSNotification.Name("modalView.createTask"), object: nil, userInfo: [
                "id": id,
                "name": name,
                "description": description,
                "date": date
                ])
            //Creamos o actualizamos la tarea
            createNotification(id: id)
            
            viewCleaner()
            
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("modalView.displayAlert"), object: nil)
        }
        
    }
    
}
