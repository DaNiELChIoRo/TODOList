//
//  AutolayoutHelper.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func topViewAutoAnchors(vista: UIView, heightPercentage:CGFloat, sidePadding:CGFloat ,topPadding:CGFloat){
        NSLayoutConstraint.activate([
            (vista.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*(topPadding/736))),
            (vista.centerXAnchor.constraint(equalTo: view.centerXAnchor)),
            (vista.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: heightPercentage)),
            (vista.widthAnchor.constraint(equalTo: view.widthAnchor, constant: sidePadding*(-2)))
            ])
    }
    
    func topAutoAnchors(id:Int, heightPercentage:CGFloat, sidePadding:CGFloat ,topPadding:CGFloat){
        NSLayoutConstraint.activate([
            (view.viewWithTag(id)?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*(topPadding/736)))!,
            (view.viewWithTag(id)?.centerXAnchor.constraint(equalTo: view.centerXAnchor))!,
            (view.viewWithTag(id)?.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: heightPercentage))!,
            (view.viewWithTag(id)?.widthAnchor.constraint(equalTo: view.widthAnchor, constant: sidePadding*(-2)))!
            ])
    }
    
    func AutoAnchors(id:Int, topView: Int, heightPercentage:CGFloat, sidePadding:CGFloat ,topPadding:CGFloat){
        NSLayoutConstraint.activate([
            (view.viewWithTag(id)?.topAnchor.constraint(equalTo: (view.viewWithTag(topView)?.bottomAnchor)!, constant: view.frame.height*(topPadding/736)))!,
            (view.viewWithTag(id)?.centerXAnchor.constraint(equalTo: view.centerXAnchor))!,
            (view.viewWithTag(id)?.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: heightPercentage))!,
            (view.viewWithTag(id)?.widthAnchor.constraint(equalTo: view.widthAnchor, constant: sidePadding*(-2)))!
            ])
    }
    
}
