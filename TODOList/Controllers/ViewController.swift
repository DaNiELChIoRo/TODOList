//
//  ViewController.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ViewController: UITableViewController {
    
    let height:CGFloat = UIScreen.main.bounds.height * 0.5
    let width = UIScreen.main.bounds.width - 40
    let centerY:CGFloat = 20
    let totalHeight = UIScreen.main.bounds.height
        
    let modalView = ModalView()
    let addTaskView = AddTaskView()
    
    var rowAdderDelegate: rowAdder!
    
    var tareas = [Tarea]()
    
    var taskName:String = ""
    var taskDetail: String = ""
    var taskDate: String = ""
    
    let dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MMM/yyyy hh:mm"
        return formatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavBar()
        setupView()
        addObservers()
        CoreData()
        self.records()
//        AddTaskView.shared.rowAdderDelegate = TableViewDelegate.shared
    }
    
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(newView), name: NSNotification.Name("viewNotification.changeView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(presentAlert), name: NSNotification.Name("viewNotification.displayAlert"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tapHandler), name: NSNotification.Name("viewNotification.removeAddView"), object: nil)                
    }

    func setupView(){
        view.backgroundColor = UIColor.lightGray
        navigationItem.title = "TODO List"
    }
    
    func setupNavBar(){
        let rightItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonHandler))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    //MARK:- presentDetailView
    @objc func newView(notification: Notification){
        print("datos: \(notification.userInfo)")
        guard let id = notification.userInfo?["id"] as? Int,
            let name = notification.userInfo?["name"] as? String,
            let detail = notification.userInfo?["detail"] as? String,
            let date = notification.userInfo?["date"] as? String,
            let rowIndex = notification.userInfo?["rowIndex"] as? Int
            else { return }
        
//        guard let fecha = dataFormatter.date(from: date) else { return }
//            let fechaToString = dataFormatter.string(from: date)
        
        let detailView = DetailViewController(id: id, name: name, detail: detail, date: date, rowIndex: rowIndex)
        self.navigationController?.pushViewController(detailView, animated: true)
        
    }
    
    @objc func rightBarButtonHandler(){
        print("right action")
       
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
    
    //MARK:- presentAlert
    @objc func presentAlert(){
        print("presentAlert Handler hass been trigered!")
        let alert = UIAlertController(title: "Mensaje de Alerta", message: "No se han llenado todos los campos", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Entendido", style: .destructive, handler: nil))
        
        //Removiendo las UIViews de la vista principal
        self.modalView.removeFromSuperview()
        self.addTaskView.removeFromSuperview()
        
        //Volviendo a habilitar el botón para añadir tareas
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        
        self.present(alert, animated: true, completion: nil)
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

extension ViewController: rowAdder{
    func addRow(id: Int64, name: String, detail: String, date: String) {
        print("this code snipped should be executed!")
    
        
    }
}
