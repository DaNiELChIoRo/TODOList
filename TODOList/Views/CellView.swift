//
//  CellView.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/30/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

class CellView: UITableViewCell {
    
    let name: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sample Item"
        label.textColor = UIColor.black
        return label
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sample date"
        label.textColor = UIColor.black
        return label
    }()
    
    static let shared = CellView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        addSubview(name)
        addSubview(date)
        addConstraints(self.LayoutWithVisualFormat(visualFormat: "H:|-16-[nameLabel]-20-[dateLabel]-16-|", alignment: .alignAllCenterY, view: ["nameLabel": name, "dateLabel": date]))
        addConstraints(self.LayoutWithVisualFormat(visualFormat: "V:|-[nameLabel]-|", alignment: .alignAllCenterY, view: ["nameLabel": name]))
        addConstraints(self.LayoutWithVisualFormat(visualFormat: "V:|-[dateLabel]-|", alignment: .alignAllCenterY, view: ["dateLabel": date]))        
    }
    
}
