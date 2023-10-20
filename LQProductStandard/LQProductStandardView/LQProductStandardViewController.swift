//
//  LQProductStandardViewController.swift
//  LQProductStandard
//
//  Created by qiukua on 2023/10/16.
//

import UIKit

class LQProductStandardViewController: UIViewController {
    
    
    var proStandardLab:UILabel?
    
    lazy var dataSource : [LQProStandardModel] = {
        var array = [LQProStandardModel]()
        return array
    }()

    lazy var proSkuView:LQProductStandardView = {
        var proSkuView = LQProductStandardView(frame: CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT),dataSource: self.dataSource)
        proSkuView.themeColor = .red
        proSkuView.normalColor = rgbs(s: 230)
        //点击确定按钮的回调
        proSkuView.dismissBlock = {
            UIView.animate(withDuration: 0.5) {
                self.proSkuView.y = SCREEN_HEIGHT
            }
        }
        //点选属性规格时候的回调（每次点击的时候都会回调一次）
        proSkuView.productStandardBlock = { (proStandardsStr,proStandardIdsStr,isReady) in
            if isReady {
                self.proStandardLab?.text = proStandardsStr
                print("proStandardIdsStr is \(proStandardIdsStr)")
            }else{
                self.proStandardLab?.text = "请选择规格"
            }
        }
        proSkuView.cbProductStandardString()
        let window = UIApplication.shared.keyWindow
        window?.addSubview(proSkuView)
        return proSkuView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self .initializeData()
        
        self .setupSubviews()
        
        
    }
    
    func initializeData() {
        let path = Bundle.main.path(forResource: "proJson", ofType: "txt")
        let proJson:String = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        let resObj = self.jsonStringToDictionary(proJson) as Dictionary
        if(Int(resObj["code"] as! String) == 200){
            let data = resObj["data"] as! NSDictionary
            let jsonGroupArray = data["jsonGroupArray"] as! Array<Any>
            for (i,obj) in jsonGroupArray.enumerated() {
                let model = LQProStandardModel.modelWithDictionary(obj as! Dictionary)
                model.proIdx = i
                self.dataSource.append(model)
            }
        }
    }
    
    func setupSubviews() {
        let pullStandardBtn:UIButton = UIButton(type: .custom).xy_frame(CGRectMake(100, 100, 100*WidthRatio, 48*WidthRatio)).xy_title("弹出规格按钮").xy_addTarget(self, #selector(btnAction), .touchUpInside).xy_titleFont(FontSize(size: 13)).xy_backgroundClor(.red) as! UIButton
        pullStandardBtn.center = view.center
        self.view.addSubview(pullStandardBtn)
        
        proStandardLab = UILabel(frame: CGRectMake(15*WidthRatio, pullStandardBtn.bottomY+40*WidthRatio, SCREEN_WIDTH-30*WidthRatio, 20*WidthRatio)).xy_textAlignment(.center).xy_text("这里是回显的规格字符串").xy_font(FontSize(size: 13))
        self.view.addSubview(proStandardLab!)
    }
    
    @objc func btnAction() {
        UIView.animate(withDuration: 0.5) {
            self.proSkuView.y = 0
        }
    }
    // MARK: --字典转json串
    func dictionaryToJsonString(_ dictionary:Dictionary<String, Any>) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
    // MARK: --json串转字典
    func jsonStringToDictionary(_ jsonString:String) -> Dictionary<String, Any> {
        let jsonData:Data = jsonString.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! Dictionary
        }
        return Dictionary()
    }

    
}
