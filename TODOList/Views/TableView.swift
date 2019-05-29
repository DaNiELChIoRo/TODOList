//
//  TableView.swift
//  TODOList
//
//  Created by Daniel.Meneses on 5/28/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import UIKit

class TableView: UITableView, onCellTapProtocol {
    
    let detailView = DetailViewController()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = TableViewDelegate.shared
        dataSource = TableViewDelegate.shared
        self.translatesAutoresizingMaskIntoConstraints = false
        
            TableViewDelegate.shared.records()
        
            TableViewDelegate.shared.delegate = detailView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func detailViewPresenter() {
        print("deatilViewPresent function from cell?")
        let detailView = DetailViewController()
        self.window?.rootViewController?.present(detailView, animated: true, completion: nil)
    }
    
}

class CellView: UITableViewCell {
    
    weak var name: UILabel!
    
    var delegate: onCellTapProtocol!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func presentView(_ sender: Any){
        self.delegate.detailViewPresenter()
        print("allgo")
    }
    
}

protocol onCellTapProtocol {
    func detailViewPresenter()
}
