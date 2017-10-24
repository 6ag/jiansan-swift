//
//  Common.swift
//  JianSan Wallpaper
//
//  Created by jianfeng on 16/2/4.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit
import MJRefresh

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let SCREEN_BOUNDS = UIScreen.main.bounds

/**
 拉方式
 
 - pullUp:   上拉
 - pullDown: 下拉
 */
enum PullMethod {
    case pullUp
    case pullDown
}

/**
 快速创建上拉加载更多控件
 */
func jf_setupFooterRefresh(_ target: AnyObject, action: Selector) -> MJRefreshAutoNormalFooter {
    let footerRefresh = MJRefreshAutoNormalFooter(refreshingTarget: target, refreshingAction: action)
    footerRefresh?.isAutomaticallyHidden = true
    footerRefresh?.setTitle("正在拼命加载中...", for: MJRefreshState.refreshing)
    footerRefresh?.setTitle("上拉即可加载更多壁纸...", for: MJRefreshState.idle)
    footerRefresh?.setTitle("没有更多壁纸啦...", for: MJRefreshState.noMoreData)
    return footerRefresh!
}

/**
 快速创建下拉加载最新控件
 */
func jf_setupHeaderRefresh(_ target: AnyObject, action: Selector) -> MJRefreshNormalHeader {
    let headerRefresh = MJRefreshNormalHeader(refreshingTarget: target, refreshingAction: action)
    headerRefresh?.lastUpdatedTimeLabel.isHidden = true
    headerRefresh?.stateLabel.isHidden = true
    return headerRefresh!
}

/// 导航背景颜色
let NAVBAR_TINT_COLOR = UIColor.white

/// 标题颜色
let TITLE_COLOR = UIColor(red: 142 / 255.0, green: 120 / 255.0, blue: 152 / 255.0, alpha: 1.0)

/// 标题字体
let TITLE_FONT = UIFont.systemFont(ofSize: 17)

/// 控制器背景颜色
let BACKGROUND_COLOR = UIColor(red:0.933,  green:0.933,  blue:0.933, alpha:1)

/// 全局边距
let MARGIN: CGFloat = 12

/// 全局圆角
let CORNER_RADIUS: CGFloat = 5

/// 应用id
let APPLE_ID = "1110293594"

/// 友盟APPKEY
let UM_APP_KEY = "58a1bf8ae88bad2c380013ba"

/// 微信
let WX_APP_ID = "wx4c6093e754a93fb1"
let WX_APP_SECRET = "e87cc2d5206b60e20ef6b09e830515a9"

/// QQ
let QQ_APP_ID = "1105365512"
let QQ_APP_KEY = "krvt0zS22qWqaiKW"

/// 微博
let WB_APP_KEY = "522277068"
let WB_APP_SECRET = "2be1eacdf94fb4c17a99de0f6913eab9"
let WB_REDIRECT_URL = "https://blog.6ag.cn"

// 各种iPhone屏幕的尺寸
let IPHONE_3_5_WIDTH: CGFloat = 320
let IPHONE_3_5_HEIGHT: CGFloat = 480
let IPHONE_4_0_WIDTH: CGFloat = 320
let IPHONE_4_0_HEIGHT: CGFloat = 568
let IPHONE_4_7_WIDTH: CGFloat = 375
let IPHONE_4_7_HEIGHT: CGFloat = 667
let IPHONE_5_5_WIDTH: CGFloat = 414
let IPHONE_5_5_HEIGHT: CGFloat = 736
let IPHONE_5_8_WIDTH: CGFloat = 375
let IPHONE_5_8_HEIGHT: CGFloat = 812

/// 设计图宽度
let DESIGN_WIDTH: CGFloat = IPHONE_4_7_WIDTH

/// 设计图高度
let DESIGN_HEIGHT: CGFloat = IPHONE_4_7_HEIGHT

// 判断当前设备的尺寸
let IS_IPHONE_3_5 = (SCREEN_HEIGHT > SCREEN_WIDTH ? SCREEN_HEIGHT : SCREEN_WIDTH) == IPHONE_3_5_HEIGHT
let IS_IPHONE_4_0 = (SCREEN_HEIGHT > SCREEN_WIDTH ? SCREEN_HEIGHT : SCREEN_WIDTH) == IPHONE_4_0_HEIGHT
let IS_IPHONE_4_7 = (SCREEN_HEIGHT > SCREEN_WIDTH ? SCREEN_HEIGHT : SCREEN_WIDTH) == IPHONE_4_7_HEIGHT
let IS_IPHONE_5_5 = (SCREEN_HEIGHT > SCREEN_WIDTH ? SCREEN_HEIGHT : SCREEN_WIDTH) == IPHONE_5_5_HEIGHT
let IS_IPHONE_5_8 = (SCREEN_HEIGHT > SCREEN_WIDTH ? SCREEN_HEIGHT : SCREEN_WIDTH) == IPHONE_5_8_HEIGHT

/// 状态栏高度
let STATUS_HEIGHT: CGFloat = IS_IPHONE_5_8 ? 44 : 20

/// 导航栏高度
let NAVBAR_HEIGHT: CGFloat = IS_IPHONE_5_8 ? 44 : 44

/// 状态栏+导航栏高度
let STATUS_AND_NAVBAR_HEIGHT: CGFloat = IS_IPHONE_5_8 ? 88 : 64

/// TabBar高度
let TABBAR_HEIGHT: CGFloat = IS_IPHONE_5_8 ? 83 : 49

/// iPhoneX 底部高度
let TABBAR_BOTTOM_HEIGHT: CGFloat = IS_IPHONE_5_8 ? 34 : 0
