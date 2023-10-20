//
//  UIButton+Extension.swift
//  MySwift
//
//  Created by qiukua on 2023/7/3.
//

import Foundation
import UIKit

enum XYButtonImagePosition {
    case top //上图下文
    case bottom //下图上文
    case left //左图右文
    case right //右图左文
}
extension UIButton{
    
    func xy_frame(_ frame:CGRect) -> UIButton {
        self.frame = frame
        return self
    }
    
    func xy_title(_ title:String) -> UIButton {
        self.setTitle(title, for: .normal)
        return self
    }
    
    func xy_titleColor(_ titleColor:UIColor) -> UIButton{
        self.setTitleColor(titleColor, for: .normal)
        return self
    }
    
    func xy_selectedTitle(_ selectedTitle:String) -> UIButton {
        self.setTitle(selectedTitle, for: .selected)
        return self
    }
    
    func xy_selectedtTtleColor(_ selectedTitle:UIColor) -> UIButton{
        self.setTitleColor(selectedTitle, for: .selected)
        return self
    }
    
    func xy_titleFont(_ font:UIFont) -> UIButton {
        self.titleLabel?.font = font
        return self
    }
    
    func xy_image(_ imageName:String,_ state:UIControl.State) -> UIButton{
        self.setImage(UIImage(named: imageName), for: state)
        return self
    }
    
    func xy_backgroundImage(_ imageName:String,_ state:UIControl.State) -> UIButton {
        self.setBackgroundImage(UIImage(named: imageName), for: state)
        return self
    }
    
    func xy_addTarget(_ target:Any?,_ selector:Selector,_ controlEvents:UIControl.Event) -> UIButton{
        self.addTarget(target, action: selector, for: controlEvents)
        return self
    }
    
    func xyImagePosition(style:XYButtonImagePosition,space:CGFloat){
        let imageW = self.imageView?.frame.size.width
        let imageH = self.imageView?.frame.size.height
        var labW:CGFloat! = 0.0
        var labH:CGFloat! = 0.0
        labW = self.titleLabel?.intrinsicContentSize.width
        labH = self.titleLabel?.intrinsicContentSize.height
        var imageEdgeInsets = UIEdgeInsets.zero
        var titleEdgeInsets = UIEdgeInsets.zero
        switch style {
        case.top:
            imageEdgeInsets = UIEdgeInsets(top: -labH - space/2, left: 0, bottom: 0, right: -labW)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageW!, bottom: -imageH!-space/2, right: 0)
            break
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2, bottom: 0, right: space)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: space/2, bottom: 0, right: -space/2)
            break
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labH!-space/2, right: -labW)
            titleEdgeInsets = UIEdgeInsets(top: -imageH!-space/2, left: -imageW!, bottom: 0, right: 0)
            break
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labW+space/2, bottom: 0, right: -labW - space/2)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageW!-space/2, bottom: 0, right: imageW!+space/2)
            break
        }
        self.imageEdgeInsets = imageEdgeInsets
        self.titleEdgeInsets = titleEdgeInsets
    }
    
    
}
