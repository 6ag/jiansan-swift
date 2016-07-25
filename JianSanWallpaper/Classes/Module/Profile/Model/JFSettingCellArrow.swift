//
//  JFSettingCellArrow.swift
//  JianSan Wallpaper
//
//  Created by zhoujianfeng on 16/4/27.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

class JFSettingCellArrow: JFSettingCellModel {
    
     /// 目标控制器
    var destinationVc: AnyClass?
    
    init(title: String, destinationVc: AnyClass) {
        super.init(title: title)
        self.destinationVc = destinationVc
    }
    
    override init(title: String) {
        super.init(title: title)
    }
    
    override init(title: String, icon: String) {
        super.init(title: title, icon: icon)
    }
    
    init(title: String, icon: String, destinationVc: AnyClass) {
        super.init(title: title, icon: icon)
        self.destinationVc = destinationVc
    }
}
