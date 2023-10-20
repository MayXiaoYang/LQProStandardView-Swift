//
//  UICollectionView+Extension.swift
//  MySwift
//
//  Created by qiukua on 2023/7/3.
//

import Foundation
import UIKit

extension UICollectionView{
    
    func xy_frame(_ frame:CGRect) -> UICollectionView {
        self.frame = frame
        return self
    }
    
    func xy_delegate(_ delegate:UICollectionViewDelegateFlowLayout) -> UICollectionView {
        self.delegate = delegate
        return self
    }
    
    func xy_dataSource(_ dataSource:UICollectionViewDataSource) -> UICollectionView {
        self.dataSource = dataSource
        return self
    }
    
    func xy_contentInset(_ contentInset:UIEdgeInsets) -> UICollectionView {
        self.contentInset = contentInset
        return self
    }
    
    func xy_register(_ item: UICollectionViewCell.Type) -> UICollectionView {
        self.register(item.self, forCellWithReuseIdentifier: String(describing: item.self))
        return self
    }
    
}
