//
//  JFSettingGroup.swift
//  JianSan Wallpaper
//
//  Created by zhoujianfeng on 16/4/27.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

class JFSettingGroup: NSObject {
    
     /// 单个cell模型
    var cells: [JFSettingCellModel]?
    
     /// 头部描述
    var headerDescription: String?
    
     /// 尾部描述
    var footerDescription: String?
    
    init(cells: [JFSettingCellModel]) {
        super.init()
        self.cells = cells
    }
    
}
