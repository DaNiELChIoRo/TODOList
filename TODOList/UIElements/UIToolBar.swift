//
//  UIToolBar.swift
//  TODOList
//
//  Created by Daniel.Meneses on 6/4/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

class DatePicker: UIPickerView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = DatePickerDelegate()
        dataSource = DatePickerDelegate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }
    
}

class DatePickerDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    override init() {}
    
    private let shared = DatePickerDelegate()

    var pollModel = PollModel()
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let currentDate = Date()
        var dateComponents = DateComponents()
        
        let days = pickerView.selectedRow(inComponent: 0)
        let hours = pickerView.selectedRow(inComponent: 1)
        let minutes = pickerView.selectedRow(inComponent: 2)
        
        pollModel.currentTime = (PollTime(time: days, description: ""), PollTime(time: hours, description: ""), PollTime(time: minutes, description: ""))
        
        if !pollModel.validateCurrenTime() {
            
            let alert = UIAlertController(title: "Invalid Time", message: "You must select a time greater than 10 minutes, up to 7 days.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { [weak self] action in
                [0,1,2].forEach { pickerView.selectRow(0, inComponent: $0, animated: true) }
                pickerView.reloadAllComponents()
            })
//            self.present(alert, animated: true, completion: nil)
        }
        
        dateComponents.day = days
        dateComponents.hour = hours
        dateComponents.minute = minutes
        
        let calendar = Calendar(identifier: .gregorian)
        let futureDate = calendar.date(byAdding: dateComponents, to: currentDate)
        
        print("The current date is: \(currentDate.description)")
        print("Your future date is: \(futureDate?.description ?? "")")

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(component){
        case 0:
            return pollModel.days.count
        case 1:
            return pollModel.hours.count
        case 2:
            return pollModel.minutes.count
        default:
            return 0
        }
    }
    
}

struct PollTime {
    let time: Int
    let description: String
}

struct PollModel {
        let days: [PollTime]
        let hours: [PollTime]
        let minutes: [PollTime]
        
        var currentTime: (day: PollTime, hour: PollTime, minute: PollTime)?
        
        init() {
            days = [Int](0...7).map { PollTime(time: $0, description: $0 == 0 || $0 > 1 ? "days" : "day") }
            hours = [Int](0...23).map { PollTime(time: $0, description: $0 == 0 || $0 > 1 ? "hours" : "hour") }
            minutes = [Int](0...59).map { PollTime(time: $0, description: $0 == 0 || $0 > 1 ? "min" : "min") }
        }
        
        private func timeBiggerThan10Minutes() -> Bool {
            guard let currentTime = currentTime else {
                return false
            }
            return currentTime.minute.time > 9 || currentTime.hour.time > 0 || currentTime.day.time > 0
        }
        
        private func timeLessThan7Days() -> Bool {
            guard let currentTime = currentTime else {
                return false
            }
            if currentTime.day.time == 7 {
                return currentTime.hour.time == 0 && currentTime.minute.time == 0
            }
            return currentTime.day.time < 8
        }
        
        func validateCurrenTime() -> Bool {
            return timeBiggerThan10Minutes() && timeLessThan7Days()
        }
}

