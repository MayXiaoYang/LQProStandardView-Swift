//
//  LQProStandardModel.swift
//  LQProductStandard
//
//  Created by qiukua on 2023/10/16.
//

import UIKit

class LQProStandardModel: NSObject {
    //商品父类标题
    var proStandardTitle : String? = ""
    //商品父类标题id
    var proStandardTitleId : Int? = 0
    
    var proIdx : Int = 0
    //规格选中状态
    var isSelected : Bool = false
    //商品规格数组
    var jsonGroupArray:Array<LQProStandardGroupModel>? = nil
        
    class func modelWithDictionary(_ dictionary:Dictionary<String, Any>) -> LQProStandardModel {
        let model = LQProStandardModel()
        model.proStandardTitle = model.objectOrNilForKey("propesName", dictionary as NSDictionary) as? String
        model.proStandardTitleId = model.objectOrNilForKey("propesId", dictionary as NSDictionary) as? Int
        let jsonArray = model.objectOrNilForKey("jsonArray", dictionary as NSDictionary) as! Array<Any>
        var jsArr:Array<LQProStandardGroupModel> = []
        for (index, object) in jsonArray.enumerated() {
            let model_son =  LQProStandardGroupModel.modelWithDictionary(object as! Dictionary<String, Any>)
            if(index == 0){
                model_son.isSelected = true
            }
            model_son.calItemW()
            jsArr.append(model_son)
        }
        model.jsonGroupArray = jsArr 
        return model
    }
    
    func objectOrNilForKey(_ akey:Any,_ dictionary:NSDictionary) ->Any {
        let object : Any? = dictionary.object(forKey: akey)
        return object is NSNull ? "" : object!
    }
}

class LQProStandardGroupModel: NSObject {
    //商品子类标题
    var proStandardName : String = ""
    //商品子类标题id
    var proStandardNameId : Int? = 0
    
    var proIdx : Int = 0
    //规格选中状态
    var isSelected : Bool = false
    //cell的宽度
    var itemW : Int = 0
    
    
    class func modelWithDictionary(_ dictionary:Dictionary<String, Any>) -> LQProStandardGroupModel {
        let model = LQProStandardGroupModel()
        model.proStandardName = model.objectOrNilForKey("provalue", dictionary as NSDictionary) as! String
        model.proStandardNameId = model.objectOrNilForKey("provalueId", dictionary as NSDictionary) as? Int
        return model
    }
    func objectOrNilForKey(_ akey:Any,_ dictionary:NSDictionary) ->Any {
        let object : Any? = dictionary.object(forKey: akey)
        return object is NSNull ? "" : object!
    }
    
    func calItemW(){
        self.itemW = calStringWidth(self.proStandardName, FontSize(size: 14))
    }
}
