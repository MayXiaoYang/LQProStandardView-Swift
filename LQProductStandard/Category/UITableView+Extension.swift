//
//  UITableView+Extension.swift
//  MySwift
//
//  Created by qiukua on 2023/7/3.
//

import Foundation
import UIKit

extension UITableView{
    
    func xy_frame(_ frame:CGRect) -> UITableView {
        self.frame = frame
        return self
    }
    
    func xy_delegate(_ delegate:UITableViewDelegate) -> UITableView {
        self.delegate = delegate
        return self
    }
    
    func xy_dataSource(_ dataSource:UITableViewDataSource) -> UITableView {
        self.dataSource = dataSource
        return self
    }
    
    func xy_separatorStyle(_ separatorStyle:UITableViewCell.SeparatorStyle) -> UITableView {
        self.separatorStyle = separatorStyle
        return self
    }
    
    func xy_rowHeight(_ rowHeight:CGFloat) -> UITableView {
        self.rowHeight = rowHeight
        return self
    }
    
    func xy_contentInset(_ contentInset:UIEdgeInsets) -> UITableView {
        self.contentInset = contentInset
        return self
    }
    
    func xy_estimateHeight(_ height:CGFloat) -> UITableView {
        self.estimatedSectionHeaderHeight = height
        self.estimatedSectionFooterHeight = height
        self.estimatedRowHeight = height
        return self
    }

    func xy_register(_ cell:UITableViewCell.Type) -> UITableView {
        self.register(cell.self, forCellReuseIdentifier: String(describing: cell.self))
        return self
    }
    
}
