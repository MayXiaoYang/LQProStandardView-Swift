//
//  UIImageView+Extension.swift
//  MySwift
//
//  Created by qiukua on 2023/7/3.
//

import Foundation
import UIKit

extension UIImageView{
    
    func xy_image(_ imageName:String) -> UIImageView {
        self.image = UIImage(named: imageName)
        return self
    }
    
    
}
