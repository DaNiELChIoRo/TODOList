//
//  NoTasksView.swift
//  TODOList
//
//  Created by Daniel.Meneses on 6/6/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

class NoTasksView: UIView{
    
    static let shared = NoTasksView()
    
    var label:UILabel = UILabel().labelCreator(id: 001, text: "No existen pendientes acutalmente", textColor: .black, textAlignment: .center, fontSize: 30)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        backgroundColor = UIColor.white
        addSubview(label)
        label.numberOfLines = 0
        addConstraints(self.LayoutWithVisualFormat(visualFormat: "H:|-30-[v0]-30-|", alignment: .alignAllCenterY, view: ["v0": label]))
        addConstraints(self.LayoutWithVisualFormat(visualFormat: "V:|-(>=150)-[v0]", alignment: .alignAllCenterX, view: ["v0": label]))
       
    }
    
    func removeView(){        
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            navigationController.removeFromParent()
        }
    }
    
}
