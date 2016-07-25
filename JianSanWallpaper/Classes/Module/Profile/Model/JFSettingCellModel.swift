//
//  JFSettingCellModel.swift
//  JianSan Wallpaper
//
//  Created by zhoujianfeng on 16/4/27.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

class JFSettingCellModel: NSObject {
    
    /// cell点击后的操作闭包
    typealias JFSettingOperation = () -> Void
    
    /// 标题
    var title: String?
    
    /// 子标题
    var subTitle: String?
    
    /// icon
    var icon: String?
    
    /// cell点击后的操作闭包
    var operation: JFSettingOperation?
    
    init(title: String) {
        super.init()
        self.title = title
    }
    
    init(title: String, icon: String) {
        super.init()
        self.title = title
        self.icon = icon
    }
}
