//
//  TableView.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

class TableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = TableViewDelegate.shared
        dataSource = TableViewDelegate.shared
        self.translatesAutoresizingMaskIntoConstraints = false
        
        TableViewDelegate.shared.records()        
        
        AddTaskView.shared.rowAdderDelegate = TableViewDelegate.shared
        
    }
    
//    let TaskDisplayerdelegate: tasksDisplayer!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
}



protocol onCellTapProtocol {
    func detailViewPresenter()
}
