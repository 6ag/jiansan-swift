//
//  api.swift
//  JianSan Wallpaper
//
//  Created by jianfeng on 16/2/4.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import Foundation

/// api根路径 http://jiansan.6ag.cn
let BASE_URL = "http://jiansan.6ag.cn"

/// 提交
let SUBMIT_FEEDBACK = "\(BASE_URL)/api/feedback"

/// 获取分类列表
let GET_CATEGORIES = "\(BASE_URL)/api/categories"

/// 检测壁纸保存状态
let CHECK_SAVE_STATUS = "\(BASE_URL)/api/status"

/**
 获取壁纸列表
 
 - parameter category_id: 分类id
 
 - returns: 返回api接口
 */
func GET_WALLPAPERS(category_id: Int) -> String {
    return "\(BASE_URL)/api/wallpapers/\(category_id)";
}