//
//  ViewController.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
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
        self.topViewAutoAnchors(vista: tableView, heightPercentage: 30, sidePadding: 15, topPadding: 0)
        
    }
    
    func setupNavBar(){
//        let rightItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(rightBarButtonHandler))
        let rightItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonHandler))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func rightBarButtonHandler(){
        print("right action")
        let modalViewController = ModalView()
        modalViewController.modalPresentationStyle = .overCurrentContext
        self.present(modalViewController, animated: true, completion: nil)
    }

}
