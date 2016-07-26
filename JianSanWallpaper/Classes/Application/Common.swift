//
//  Common.swift
//  JianSan Wallpaper
//
//  Created by jianfeng on 16/2/4.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit
import MJRefresh

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height
let SCREEN_BOUNDS = UIScreen.mainScreen().bounds

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
func jf_setupFooterRefresh(target: AnyObject, action: Selector) -> MJRefreshAutoNormalFooter {
    let footerRefresh = MJRefreshAutoNormalFooter(refreshingTarget: target, refreshingAction: action)
    footerRefresh.automaticallyHidden = true
    footerRefresh.setTitle("正在拼命加载中...", forState: MJRefreshState.Refreshing)
    footerRefresh.setTitle("上拉即可加载更多壁纸...", forState: MJRefreshState.Idle)
    footerRefresh.setTitle("没有更多壁纸啦...", forState: MJRefreshState.NoMoreData)
    return footerRefresh
}

/**
 快速创建下拉加载最新控件
 */
func jf_setupHeaderRefresh(target: AnyObject, action: Selector) -> MJRefreshNormalHeader {
    let headerRefresh = MJRefreshNormalHeader(refreshingTarget: target, refreshingAction: action)
    headerRefresh.lastUpdatedTimeLabel.hidden = true
    headerRefresh.stateLabel.hidden = true
    return headerRefresh
}

/// 导航背景颜色
let NAVBAR_TINT_COLOR = UIColor.whiteColor()

/// 标题颜色
let TITLE_COLOR = UIColor(red:0.943,  green:0.943,  blue:0.943, alpha:1)

/// 标题字体
let TITLE_FONT = UIFont.systemFontOfSize(18)

/// 控制器背景颜色
let BACKGROUND_COLOR = UIColor(red:0.933,  green:0.933,  blue:0.933, alpha:1)

/// 全局边距
let MARGIN: CGFloat = 12

/// 全局圆角
let CORNER_RADIUS: CGFloat = 5

/// 友盟APPKEY
let UM_APP_KEY = "57219e40e0f55a1599001df7"

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
        