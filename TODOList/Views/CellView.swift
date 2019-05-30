//
//  CellView.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/30/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

class CellView: UITableViewCell {
    
    weak var name: UILabel!
    
    static let shared = CellView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    @objc func presentView(_ sender: Any){
    //        delegate?.detailViewPresenter()
    //    }
    
}
