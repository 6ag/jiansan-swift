//
//  JFSettingCell.swift
//  JianSan Wallpaper
//
//  Created by zhoujianfeng on 16/4/27.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

class JFSettingCell: UITableViewCell {
    
    /// 是否显示分割线
    var showLineView: Bool = false {
        didSet {
            settingLineView.hidden = !showLineView
        }
    }
    
    /// cell模型
    var cellModel: JFSettingCellModel? {
        didSet {
            
            // 左边数据
            textLabel?.text = cellModel!.title
            detailTextLabel?.text = cellModel!.subTitle
            
            if cellModel?.icon != nil {
                imageView?.image = UIImage(named: cellModel!.icon!)
            } else {
                imageView?.image = nil
            }
            
            // 右边数据
            selectionStyle = cellModel!.isKindOfClass(JFSettingCellArrow.self) ? .Default : .None
            if cellModel!.isKindOfClass(JFSettingCellArrow.self) {
                accessoryView = settingArrowView
            } else if cellModel!.isKindOfClass(JFSettingCellSwitch.self) {
                let settingCellSwitch = cellModel as! JFSettingCellSwitch
                settingSwitchView.on = settingCellSwitch.on
                accessoryView = settingSwitchView
            } else if cellModel!.isKindOfClass(JFSettingCellLabel.self) {
                let settingCellLabel = cellModel as! JFSettingCellLabel
                settingRightLabel.text = settingCellLabel.text
                accessoryView = settingRightLabel
            }
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 准备视图
        prepareUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let lineX = textLabel!.frame.origin.x
        let lineH: CGFloat = 0.5
        let lineY = frame.size.height - lineH
        let lineW = frame.size.width - lineX
        settingLineView.frame = CGRect(x: lineX, y: lineY, width: lineW, height: lineH)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareUI() {
        
        textLabel?.font = UIFont.systemFontOfSize(14)
        textLabel?.textColor = UIColor.blackColor()
        
        detailTextLabel?.font = UIFont.systemFontOfSize(11)
        detailTextLabel?.textColor = UIColor.blackColor()
        
        contentView.addSubview(settingLineView)
    }
    
    @objc private func didChangedSwitch() {
        
    }
    
    // MARK: - 懒加载
    lazy var settingRightLabel: UILabel = {
        let settingRightLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        settingRightLabel.textColor = UIColor.grayColor()
        settingRightLabel.textAlignment = .Right
        settingRightLabel.font = UIFont.systemFontOfSize(14)
        return settingRightLabel
    }()
    
    lazy var settingArrowView: UIImageView = {
        let settingArrowView = UIImageView(image: UIImage(named: "setting_arrow_icon"))
        return settingArrowView
    }()
    
    lazy var settingSwitchView: UISwitch = {
        let settingSwitchView = UISwitch()
        settingSwitchView.addTarget(self, action: #selector(didChangedSwitch), forControlEvents: .ValueChanged)
        return settingSwitchView
    }()
    
    lazy var settingLineView: UIView = {
        let settingLineView = UIView()
        settingLineView.backgroundColor = UIColor.blackColor()
        settingLineView.alpha = 0.1
        return settingLineView
    }()
    
}
