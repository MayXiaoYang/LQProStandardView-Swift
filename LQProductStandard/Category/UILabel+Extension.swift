//
//  UILabel+Extention.swift
//  MySwift
//
//  Created by qiukua on 2023/7/3.
//

import Foundation
import UIKit

extension UILabel{
    
    
    func xy_frame(_ frame:CGRect) -> UILabel {
        self.frame = frame
        return self
    }
    
    func xy_text(_ text:String) -> UILabel {
        self.text = text
        return self
    }
    
    func xy_font(_ font:UIFont) -> UILabel{
        self.font = font
        return self
    }
    
    func xy_textColor(_ textColor:UIColor) -> UILabel{
        self.textColor = textColor
        return self
    }
    
    func xy_textAlignment(_ textAlignment:NSTextAlignment) -> UILabel {
        self.textAlignment = textAlignment
        return self
    }
    
    func xy_numberOfLines(_ numberOfLines:Int) -> UILabel{
        self.numberOfLines = numberOfLines
        return self
    }
    
    
}
