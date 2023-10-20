# LQProStandardView-Swift
商品规格选择view--- Swift版本
####使用示例--传入与demo中结构相同的数组即可
```
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
```
