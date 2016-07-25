//
//  JFCategoryModel.swift
//  JianSan Wallpaper
//
//  Created by zhoujianfeng on 16/4/23.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

class JFCategoryModel: NSObject {
    
    /// 图标字符串
    var iconName: String?
    
    /// 分别标题
    var title: String?
    
    /// 分类
    var category: String?
    
    init(dict: [String : String]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
}
