//
//  LQPch.swift
//  LQProductStandard
//
//  Created by qiukua on 2023/10/16.
//

import Foundation
import UIKit

//屏幕适配相关
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let WidthRatio = SCREEN_WIDTH/375.0
let HeightRatio = SCREEN_HEIGHT/667.0

let StatusBarH = UIApplication.shared.statusBarFrame.size.height
let NavBarH = (StatusBarH > 20) ? 88 : 64
let TabBarH = (StatusBarH > 20) ? 83 : 49
let SafeArea = (StatusBarH > 20) ? 34.0 : 0.0

//设备是否是iPhoneX以上的机型
func isIphoneX() -> Bool{
    var isDeviceX = false
    if #available(iOS 11.0, *){
        if SafeArea > 0{
            isDeviceX = true
        }
    }
    return isDeviceX
}

//RGB颜色
func rgba(r: CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor{
    UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
func rgbs(s: CGFloat) -> UIColor{
    UIColor(red: s/255.0, green: s/255.0, blue: s/255.0, alpha: 1)
}

//适配字体大小
func FontSize(size:CGFloat) -> UIFont{
    UIFont.systemFont(ofSize: size)
}
func fontsize(size:CGFloat) -> CGFloat{
    if SCREEN_WIDTH > 320{
        return size + 1
    }else if SCREEN_WIDTH == 375{
        return size
    }else{
        return size - 1
    }
}

func lqJsonStr (info:Dictionary<String, Any>){
    let jsonData = try? JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
    let jsonStr = String(data: jsonData!, encoding: String.Encoding.utf8)
    print("JsonStr----->>\(jsonStr ?? "字典为空")")
}

func calStringWidth(_ text:String,_ fontSize:UIFont) -> Int {
    // 创建一个字符串
    let attributedString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: fontSize])
    // 使用NSString的size方法来计算文本的大小
    let size = attributedString.size()
    // 获取文本的宽度
    return Int(ceil(size.width))
}
