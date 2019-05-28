//
//  ModalViewController.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import Foundation
import UIKit

class ModalView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupView()
    }
    
    let settingsV:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        
        view.layer.cornerRadius = 53
        return view
    }()
    
    let DatePicker:UIDatePicker = {
       let datePicker = UIDatePicker()
        
        return datePicker
    }()
    
    private func setupView(){
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        view.isOpaque = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        view.addGestureRecognizer(tap)
        
        
        view.addSubview(settingsV)
        self.topViewAutoAnchors(vista: settingsV, heightPercentage: 30, sidePadding: 30, topPadding: 20)
        
        settingsV.addSubview()
        
    }
    
    private func setupNavBar(){
        let rightItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonHandler))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func tapHandler(){
        print("tap has been made")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func rightBarButtonHandler(){
        
    }
    
}
