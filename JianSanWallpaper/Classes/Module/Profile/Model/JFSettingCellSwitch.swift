//
//  JFSettingCellSwitch.swift
//  JianSan Wallpaper
//
//  Created by zhoujianfeng on 16/4/27.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

class JFSettingCellSwitch: JFSettingCellModel {
    
    typealias JFSettingCellSwitchOn = (on: Bool) -> Void
    
    /// 开关状态
    var on: Bool = false
    
    /// 状态闭包
    var onClosure: JFSettingCellSwitchOn?
    
}
