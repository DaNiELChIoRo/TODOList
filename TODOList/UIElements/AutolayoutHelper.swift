//
//  AutolayoutHelper.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

extension UIView {
    
    func topViewAutoAnchors(vista: UIView, heightPercentage:CGFloat, sidePadding:CGFloat ,topPadding:CGFloat){
        NSLayoutConstraint.activate([
            (vista.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: self.frame.height*(topPadding/736))),
            (vista.centerXAnchor.constraint(equalTo: self.centerXAnchor)),
            (vista.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: heightPercentage)),
            (vista.widthAnchor.constraint(equalTo: self.widthAnchor, constant: sidePadding*(-2)))
            ])
    }
    
    func centerViewAutoAnchors(vista: UIView, heightPercentage:CGFloat, sidePadding:CGFloat){        
        NSLayoutConstraint.activate([
            (vista.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: self.frame.size.height * heightPercentage / 2)),
            (vista.centerXAnchor.constraint(equalTo: self.centerXAnchor)),
//            (vista.centerYAnchor.constraint(equalTo: view.centerYAnchor)),
            (vista.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: heightPercentage)),
            (vista.widthAnchor.constraint(equalTo: self.widthAnchor, constant: sidePadding*(-2)))
            ])
    }
    
    func topAutoAnchors(id:Int, heightPercentage:CGFloat, sidePadding:CGFloat ,topPadding:CGFloat){
        NSLayoutConstraint.activate([
            (self.viewWithTag(id)?.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: self.frame.height*(topPadding/736)))!,
            (self.viewWithTag(id)?.centerXAnchor.constraint(equalTo: self.centerXAnchor))!,
            (self.viewWithTag(id)?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: heightPercentage))!,
            (self.viewWithTag(id)?.widthAnchor.constraint(equalTo: self.widthAnchor, constant: sidePadding*(-2)))!
            ])
    }
    
    func AutoAnchors(id:Int, topView: Int, heightPercentage:CGFloat, sidePadding:CGFloat ,topPadding:CGFloat){
        NSLayoutConstraint.activate([
            (self.viewWithTag(id)?.topAnchor.constraint(equalTo: (self.viewWithTag(topView)?.bottomAnchor)!, constant: self.frame.height*(topPadding/736)))!,
            (self.viewWithTag(id)?.centerXAnchor.constraint(equalTo: self.centerXAnchor))!,
            (self.viewWithTag(id)?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: heightPercentage))!,
            (self.viewWithTag(id)?.widthAnchor.constraint(equalTo: self.widthAnchor, constant: sidePadding*(-2)))!
            ])
    }
    
    //Para vistas que no hayan sido creadas mediante metodos
    func AutoAnchors(vista: UIView, topView:Int, heightPercentage:CGFloat, sidePadding:CGFloat){
        NSLayoutConstraint.activate([
            (vista.topAnchor.constraint(equalTo: (self.viewWithTag(topView)?.bottomAnchor)!, constant: self.frame.size.height * heightPercentage / 2)),
            (vista.centerXAnchor.constraint(equalTo: self.centerXAnchor)),
            //            (vista.centerYAnchor.constraint(equalTo: view.centerYAnchor)),
            (vista.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: heightPercentage)),
            (vista.widthAnchor.constraint(equalTo: self.widthAnchor, constant: sidePadding*(-2)))
            ])
    }
    
    //Para las vistas que hayan sido creadas mediante metodos y tienen una vista 
    func AutoAnchors(id: Int, topView:UIView, heightPercentage:CGFloat, sidePadding:CGFloat, topPadding:CGFloat){
        NSLayoutConstraint.activate([
            (self.viewWithTag(id)?.topAnchor.constraint(equalTo: (topView.bottomAnchor), constant: self.frame.height*(topPadding/736)))!,
            (self.viewWithTag(id)?.centerXAnchor.constraint(equalTo: self.centerXAnchor))!,
            (self.viewWithTag(id)?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: heightPercentage))!,
            (self.viewWithTag(id)?.widthAnchor.constraint(equalTo: self.widthAnchor, constant: sidePadding*(-2)))!
            ])
    }
    
}
