//
//  NavigationControllerDelegate.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

class DelegateNavigationController: NSObject, UINavigationControllerDelegate {
    private override init() {}
    
    static let shared = DelegateNavigationController()
    let navigationController = UINavigationController()
    
    func authorize(){
        navigationController.delegate = self
    }
    
}
