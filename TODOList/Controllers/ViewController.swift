//
//  ViewController.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let height:CGFloat = UIScreen.main.bounds.height * 0.5
    let width = UIScreen.main.bounds.width - 40
    let centerY:CGFloat = 20
    let totalHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavBar()
        setupView()
        
    }

    func setupView(){
        view.backgroundColor = UIColor.lightGray
        navigationItem.title = "TODO List"
        
        let tableView = TableView()
        
        view.addSubview(tableView)
        view.topViewAutoAnchors(vista: tableView, heightPercentage: 30, sidePadding: 15, topPadding: 0)
        
    }
    
    func setupNavBar(){
        let rightItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonHandler))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    let modalView = ModalView()
    let addTaskView = AddTaskView()
    
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
