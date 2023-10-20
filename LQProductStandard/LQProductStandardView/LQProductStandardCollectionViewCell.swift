//
//  LQProductStandardCollectionViewCell.swift
//  LQProductStandard
//
//  Created by qiukua on 2023/10/16.
//

import UIKit

class LQProductStandardCollectionViewCell: UICollectionViewCell {
//    var model:LQProStandardGroupModel?
    var standardLab:UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    func setupSubviews() {
        standardLab = UILabel(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)).xy_text("规格").xy_font(FontSize(size: 14)).xy_textAlignment(.center).xy_cornerRadius(3*WidthRatio) as? UILabel
        self.addSubview(standardLab!)
    }
    
    var model:LQProStandardGroupModel? {
        didSet {
            standardLab?.text = model?.proStandardName
            standardLab?.width = CGFloat(model?.itemW ?? 0) + 25*WidthRatio
            standardLab?.textColor = model?.isSelected ?? false ? .white : .black
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
