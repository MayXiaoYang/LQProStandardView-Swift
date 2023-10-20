//
//  LQProStandardCollectionReusableView.swift
//  LQProductStandard
//
//  Created by qiukua on 2023/10/16.
//

import UIKit

class LQProStandardCollectionReusableView: UICollectionReusableView {
    
    var standardTitleLab:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    var model:LQProStandardModel? {
        didSet {
            standardTitleLab?.text = model?.proStandardTitle
        }
    }
    
    func setupSubviews() {
        standardTitleLab = UILabel(frame: CGRectMake(15*WidthRatio, 10*WidthRatio, SCREEN_WIDTH - 30*WidthRatio, 14*WidthRatio))
        standardTitleLab?.font = FontSize(size: 15)
        standardTitleLab?.textAlignment = .left
        standardTitleLab?.textColor = .black
        self.addSubview(standardTitleLab!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
