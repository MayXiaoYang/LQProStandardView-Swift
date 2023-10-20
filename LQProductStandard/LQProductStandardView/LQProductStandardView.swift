//
//  LQProductStandardView.swift
//  LQProductStandard
//
//  Created by qiukua on 2023/10/16.
//

import UIKit

class LQProductStandardView: UIView,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
         
    var numTF:UITextField?
    var productImgV:UIImageView?
    var priceLab:UILabel?
    var stockLab:UILabel?
    var standardLab:UILabel?
    var sureBtn:UIButton?
    
    var proStandardStr:String?
    var proNum:Int? = 1
    var proStock:Int? = 100
    var themeColor:UIColor? {
        didSet {
            sureBtn?.backgroundColor = themeColor
        }
    }
    var normalColor:UIColor? = rgbs(s: 230)
    
    
    var productStandardBlock: ((_ proStandardsStr:String,_ proStandardIdsStr:String,_ isReady:Bool) ->Void)?
    
    var dismissBlock: (() ->Void)?
    
    init(frame: CGRect,dataSource:Array<LQProStandardModel>) {
        super.init(frame: frame)
        self.dataSource = dataSource
        themeColor = .red
        setupSubviews()
    }
    
    
    func setupSubviews(){
        
        self.backgroundColor = .black.withAlphaComponent(0.3)
        
        self.addSubview(productMsgview)
        
        productImgV = UIImageView(frame: CGRect(x: 15*WidthRatio, y: 15*WidthRatio, width: 75*WidthRatio, height: 75*WidthRatio)).xy_image("jinyi").xy_cornerRadius(5*WidthRatio) as? UIImageView
        productMsgview.addSubview(productImgV!)
        
        priceLab = UILabel(frame: CGRect(x: productImgV!.rightX + 10*WidthRatio, y: 15*WidthRatio, width: SCREEN_WIDTH - productImgV!.rightX - 25*WidthRatio, height: 15*WidthRatio)).xy_font(FontSize(size: 15)).xy_text("价格：￥19999")
        productMsgview.addSubview(priceLab!)
        
        stockLab = UILabel(frame: CGRect(x: priceLab!.x, y: priceLab!.bottomY + 10*WidthRatio, width: SCREEN_WIDTH - productImgV!.rightX - 25*WidthRatio, height: 15*WidthRatio)).xy_font(FontSize(size: 12)).xy_text("库存：剩余9999件")
        productMsgview.addSubview(stockLab!)
        
        standardLab = UILabel(frame: CGRect(x: priceLab!.x, y: stockLab!.bottomY + 10*WidthRatio, width: SCREEN_WIDTH - productImgV!.rightX - 25*WidthRatio, height: 15*WidthRatio)).xy_font(FontSize(size: 14)).xy_text("请选择规格")
        productMsgview.addSubview(standardLab!)
        
        initializeData()
        
        self.addSubview(collectionView)
        
        self.addSubview(bottomToolView)
        
        let proNumView = UIView(frame: CGRect(x: 15*WidthRatio, y: 10*WidthRatio, width: SCREEN_WIDTH - 30*WidthRatio, height: 40*WidthRatio)).xy_backgroundClor(.white)
        proNumView.autoresizingMask = .flexibleTopMargin
        bottomToolView.addSubview(proNumView)
        
        let numTextLab:UILabel = UILabel(frame: CGRect(x: 15*WidthRatio, y: 0, width: 69*WidthRatio, height: 40*WidthRatio)).xy_textColor(rgbs(s: 16)).xy_font(FontSize(size: 13)).xy_text("数量")
        bottomToolView.addSubview(numTextLab)
        
        let reduceBtn:UIButton = UIButton(frame: CGRect(x: proNumView.width - 99*WidthRatio, y: 5*WidthRatio, width: 30*WidthRatio, height: 30*WidthRatio)).xy_title("-").xy_titleColor(rgbs(s: 230)).xy_addTarget(self, #selector(btnClick(sender:)), .touchUpInside).xy_cornerRadius(3*WidthRatio).xy_tag(66).xy_borderColor(rgbs(s: 230)).xy_borderWidth(1*WidthRatio) as! UIButton
        reduceBtn.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        bottomToolView.addSubview(reduceBtn)
        
        numTF = UITextField(frame: CGRect(x: reduceBtn.rightX, y: 5*WidthRatio, width: 40*WidthRatio, height: 30*WidthRatio))
        numTF?.isUserInteractionEnabled = false
        numTF?.borderStyle = .none
        numTF?.text = "1"
        numTF?.addBorder(position: .top, color: rgbs(s: 230), width: Float(1*WidthRatio))
        numTF?.addBorder(position: .bottom, color: rgbs(s: 230), width: Float(1*WidthRatio))
        numTF?.textAlignment = .center
        bottomToolView.addSubview(numTF!)
        
        let addBtn:UIButton = UIButton(frame: CGRect(x: numTF!.rightX, y: 5*WidthRatio, width: 30*WidthRatio, height: 30*WidthRatio)).xy_title("+").xy_titleColor(rgbs(s: 230)).xy_addTarget(self, #selector(btnClick(sender:)), .touchUpInside).xy_cornerRadius(3*WidthRatio).xy_tag(67).xy_borderColor(rgbs(s: 230)).xy_borderWidth(1*WidthRatio) as! UIButton
        addBtn.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        bottomToolView.addSubview(addBtn)
        
        sureBtn = UIButton(frame: CGRect(x: 15*WidthRatio, y: proNumView.bottomY+5*WidthRatio, width: SCREEN_WIDTH - 30*WidthRatio, height: 40*WidthRatio)).xy_title("确定").xy_titleColor(.white).xy_addTarget(self, #selector(btnClick(sender:)), .touchUpInside).xy_cornerRadius(5*WidthRatio).xy_tag(68).xy_backgroundClor(themeColor!) as? UIButton
        bottomToolView.addSubview(sureBtn!)
        
        perform(#selector(delayMethod), with: nil, afterDelay: 0.2)
        
        collectionView.isHidden = true
    }
    //MARK: UICollectionView的delegate和datasource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = dataSource[section]
        return model.jsonGroupArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "LQProductStandardCollectionViewCell", for: indexPath) as! LQProductStandardCollectionViewCell
        let model = dataSource[indexPath.section]
        let model_son = model.jsonGroupArray?[indexPath.row] as? LQProStandardGroupModel
        item.model = model_son
        item.standardLab?.backgroundColor = model_son?.isSelected ?? false ? themeColor! : normalColor!
        return item
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(CGFloat(dataSource[indexPath.section].jsonGroupArray?[indexPath.row].itemW ?? 10) + 25*WidthRatio, 30*WidthRatio)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        for i in 0..<dataSource.count {
            if indexPath.section == i {
                let jsonGroupArray = dataSource[i].jsonGroupArray!
                for (idx,obj) in jsonGroupArray.enumerated() {
                    if (idx == indexPath.item) {
                        obj.isSelected = !obj.isSelected
                        if (obj.isSelected) {
                            selectedDataSource.append(obj)
                        }else{
                            selectedDataSource.removeAll(where: {$0.proStandardNameId == obj.proStandardNameId})
                        }
                    }else {
                        obj.isSelected = false
                        selectedDataSource.removeAll(where: {$0.proStandardNameId == obj.proStandardNameId})
                    }
                }
            }
        }
        UIView.performWithoutAnimation {
            collectionView.reloadData()
        }
        cbProductStandardString()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "UICollectionElementKindSectionHeader" {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: "LQProStandardCollectionReusableView", for: indexPath) as! LQProStandardCollectionReusableView
            let model = dataSource[indexPath.section]
            headerView.model = model
            return headerView
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(SCREEN_WIDTH, 34*WidthRatio)
    }
    //MARK: 事件处理
    @objc func btnClick(sender:UIButton) {
        if sender.tag == 66 {
            if proNum! > 1{
                proNum! -= 1
            }
            self.numTF?.text = String(proNum!)
        }else if sender.tag == 67 {
            if proNum! < proStock!{
                proNum! += 1
            }
            self.numTF?.text = String(proNum!)
        }else if sender.tag == 68 {
            dismissBlock?()
        }
    }
    
    //MARK: 自定义事件
    //初始化数据
    func initializeData() {
        for model in dataSource{
            for (i,model_son) in model.jsonGroupArray!.enumerated(){
                if i == 0{
                    selectedDataSource.append(model_son)
                }
                model_son.proIdx = model.proIdx
            }
        }
    }
    
    func cbProductStandardString() {
        
        if selectedDataSource.count == dataSource.count {
            let count = selectedDataSource.count
            for i in 0..<count-1 {
                for j in 0..<count - 1 - i {
                    if selectedDataSource[j].proIdx > selectedDataSource[j+1].proIdx {
                        selectedDataSource.swapAt(j, j+1)
                    }
                }
            }
            let proStandardNameArr = selectedDataSource.map { obj in
                return obj.proStandardName
            }
            let proStandardTitleIdArr = dataSource.map { obj in
                return obj.proStandardTitleId
            }
            let idsArr = selectedDataSource.map { obj in
                return obj.proStandardNameId
            }
            var idsArray:Array = Array<String>()
            for i in 0..<proStandardTitleIdArr.count {
                let modelId = String(proStandardTitleIdArr[i]!)
                let modelSonId = String(idsArr[i]!)
                let ids = modelId + ":" + modelSonId
    //            let a = String(format: "%@:%@", modelId,modelSonId)
                idsArray.append(ids)
            }
            productStandardBlock?(proStandardNameArr.joined(separator: ":"),idsArray.joined(separator: ";"),true)
            self.standardLab?.text = proStandardNameArr.joined(separator: ":")
        }else{
            productStandardBlock?("","",false)
            self.standardLab?.text = "请选择规格"
        }
        
        
    }
    
   @objc func delayMethod() {
       //collectionView的内容高度
       let collectionViewSizeHeight = self.collectionView.contentSize.height
       //collectionView的最大高度
       let collectionViewMaxHeight = SCREEN_HEIGHT - 400*WidthRatio - SafeArea
       //如果collectionView的内容高度大于SCREEN_HEIGHT - 400*WidthRatio
       if (collectionViewSizeHeight > collectionViewMaxHeight) {
           collectionView.height = collectionViewMaxHeight
           collectionView.y = bottomToolView.y - collectionView.height
           productMsgview.y = collectionView.y - productMsgview.height
       }else{
           collectionView.height = collectionViewSizeHeight
           collectionView.y = bottomToolView.y - collectionView.height
           productMsgview.y = collectionView.y - productMsgview.height
       }
       collectionView.isHidden = false
       productMsgview.isHidden = false
       bottomToolView.isHidden = false
    }
    
    //MARK: 懒加载
    lazy var dataSource:[LQProStandardModel] = {
       let dataSource = [LQProStandardModel]()
        return dataSource
    }()
    lazy var selectedDataSource:[LQProStandardGroupModel] = {
        let dataSource = [LQProStandardGroupModel]()
         return dataSource
     }()
    // 商品信息view
    lazy var productMsgview:UIView = {
       let proMsgV = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 100*WidthRatio))
        proMsgV.backgroundColor = .white
        proMsgV.isHidden = true
        return proMsgV
    }()
    //商品规格View
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewLeftAlignedLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10*WidthRatio
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15*WidthRatio, bottom: 10*WidthRatio, right: 15*WidthRatio)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 200*WidthRatio), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LQProductStandardCollectionViewCell.self, forCellWithReuseIdentifier: "LQProductStandardCollectionViewCell")
        collectionView.register(LQProStandardCollectionReusableView.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: "LQProStandardCollectionReusableView")
        return collectionView
    }()
    //底部工具view
    lazy var bottomToolView:UIView = {
        let bottomToolView = UIView(frame: CGRect(x: 0, y: self.frame.size.height - 100*WidthRatio - CGFloat(SafeArea), width: SCREEN_WIDTH, height: 100*WidthRatio + CGFloat(SafeArea))).xy_backgroundClor(.white)
        self.addSubview(bottomToolView)
        return bottomToolView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
