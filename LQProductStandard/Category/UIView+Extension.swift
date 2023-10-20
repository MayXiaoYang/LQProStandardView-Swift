//
//  UIView+Extension.swift
//  MySwift
//
//  Created by qiukua on 2023/7/3.
//

import Foundation
import UIKit

enum XYBorderPosition {
    case top //上
    case bottom //下
    case left //左
    case right //右
}

extension UIView{
    
    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newValue){
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var y : CGFloat{
        get{
            return self.frame.origin.y
        }
        set(newValue){
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var width: CGFloat {
        get{
            return self.frame.size.width
        }
        set(newValue){
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var height: CGFloat {
        get{
            return self.frame.size.height
        }
        set(newValue){
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var rightX : CGFloat{
        get{
            return self.x + self.width
        }
    }
    
    var bottomY: CGFloat {
        get{
            return self.y + self.height
        }
    }
    
    var centerX: CGFloat {
        get{
            return self.center.x
        }
        set(newValue){
            var center = self.center
            center.x = newValue
            self.center = center;
        }
    }
    
    var centerY:CGFloat{
        get{
            return self.center.y
        }
        set(newValue){
            var center = self.center
            center.y = newValue
            self.center = center;
        }
    }
    
    
    func xy_cornerRadius(_ cornerRadius:CGFloat) -> UIView {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        return self
    }

    func xy_isUserInteractionEnabled(_ isUserInteractionEnabled:Bool) -> UIView{
        self.isUserInteractionEnabled = isUserInteractionEnabled;
        return self
    }
    
    func xy_backgroundClor(_ backgroundColor:UIColor) -> UIView {
        self.backgroundColor = backgroundColor
        return self
    }
    
    func xy_clipsToBounds(_ clipsToBounds:Bool) -> UIView {
        self.clipsToBounds = true
        return self
    }
    
    func xy_contentMode(_ contentMode:UIView.ContentMode) -> UIView {
        self.contentMode = contentMode
        return self
    }
    
    func xy_hidden(_ hidden:Bool) -> UIView {
        self.isHidden = hidden
        return self
    }
    
    func xy_tag(_ tag:Int) -> UIView {
        self.tag = tag
        return self
    }
    
    func xy_borderWidth(_ borderWidth:CGFloat) -> UIView {
        self.layer.borderWidth = borderWidth
        return self
    }
    
    func xy_borderColor(_ borderColor:UIColor) -> UIView {
        self.layer.borderColor = borderColor.cgColor
        return self
    }
    
    func addTapGesture(target:Any,action:Selector) {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 1
        isUserInteractionEnabled = true
        addGestureRecognizer(gesture)
    }
    
    func addBorder(position:XYBorderPosition,color:UIColor,width:Float) {
        let borderLayer = CALayer()
        borderLayer.borderWidth = CGFloat(width)
        borderLayer.borderColor = color.cgColor
        switch position {
        case .top:
            borderLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: CGFloat(width))
        case .bottom:
            borderLayer.frame = CGRect(x: 0, y: frame.size.height - CGFloat(width), width: frame.size.width, height: CGFloat(width))
        case .left:
            borderLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(width), height: frame.size.height)
        case .right:
            borderLayer.frame = CGRect(x: frame.size.width - CGFloat(width), y: 0, width: CGFloat(width), height: frame.size.height)
        }
        layer.addSublayer(borderLayer)
        layer.masksToBounds = true
    }
}

