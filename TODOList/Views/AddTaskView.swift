//
//  AddTaskView.swift
//  TODOList
//
//  Created by Daniel R Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

class AddTaskView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    let DatePicker:UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        return datePicker
    }()
    
    func setupView(){
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10
//        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(UILabel().labelCreator(id: 001, text: "Tarea", textColor: .black, textAlignment: .center, fontSize: 15))
        self.topAutoAnchors(id: 001, heightPercentage: 0.15, sidePadding: 10, topPadding: 10)
        
        self.addSubview(UITextField().textFliedCreator(id: 002, text: "Nombre de la tarea", borderColor: .iosBlue, textAlignment: .center, fontSize: 15, radius: 8))
        self.AutoAnchors(id: 002, topView: 001, heightPercentage: 0.1, sidePadding: 25, topPadding: 5)
        
        self.addSubview(UILabel().labelCreator(id: 003, text: "Descripción", textColor: .black, textAlignment: .center, fontSize: 15))
         self.AutoAnchors(id: 003, topView: 002, heightPercentage: 0.1, sidePadding: 25, topPadding: 5)
        
        self.addSubview(UITextField().textFliedCreator(id: 004, text: "Descripción de la tarea", borderColor: .iosBlue, textAlignment: .center, fontSize: 15, radius: 8))
        self.AutoAnchors(id: 004, topView: 003, heightPercentage: 0.1, sidePadding: 25, topPadding: 5)
        
        self.addSubview(UILabel().labelCreator(id: 005, text: "Fecha de realización", textColor: .black, textAlignment: .center, fontSize: 15))
        self.AutoAnchors(id: 005, topView: 004, heightPercentage: 0.1, sidePadding: 25, topPadding: 5)
        
        self.addSubview(UITextField().textFliedCreator(id: 006, text: "dd/MM/YYYY", borderColor: .iosBlue, textAlignment: .center, fontSize: 15, radius: 8))
        self.AutoAnchors(id: 006, topView: 005, heightPercentage: 0.1, sidePadding: 25, topPadding: 5)
    }
    
}
