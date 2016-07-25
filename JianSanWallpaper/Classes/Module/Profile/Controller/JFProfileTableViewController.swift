//
//  JFProfileTableViewController.swift
//  JianSan Wallpaper
//
//  Created by zhoujianfeng on 16/4/27.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit
import YYWebImage

class JFProfileTableViewController: JFBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "设置"
        
        let group1CellModel1 = JFSettingCellLabel(title: "清除缓存", icon: "setting_clear_icon", text: "\(String(format: "%.2f", CGFloat(YYImageCache.sharedCache().diskCache.totalCost()) / 1024 / 1024))M")
        group1CellModel1.operation = { () -> Void in
            JFProgressHUD.showWithStatus("正在清理")
            YYImageCache.sharedCache().diskCache.removeAllObjectsWithBlock({
                JFProgressHUD.showSuccessWithStatus("清理成功")
                group1CellModel1.text = "0.00M"
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            })
        }
        let group1 = JFSettingGroup(cells: [group1CellModel1])
        
        let group2CellModel1 = JFSettingCellArrow(title: "我的收藏", icon: "setting_star_icon", destinationVc: UIViewController.self)
        let group2 = JFSettingGroup(cells: [group2CellModel1])
        
        let group3CellModel1 = JFSettingCellArrow(title: "意见反馈", icon: "setting_feedback_icon", destinationVc: JFProfileFeedbackViewController.self)
        let group3CellModel2 = JFSettingCellArrow(title: "推荐给好友", icon: "setting_share_icon")
        group3CellModel2.operation = { () -> Void in
            UMSocialSnsService.presentSnsIconSheetView(self, appKey: nil, shareText: "这是一款剑三福利app，十二大门派海量剑三壁纸每日更新，小伙伴们快来试试吧！https://itunes.apple.com/cn/app/id1110293594", shareImage: nil, shareToSnsNames: [UMShareToSina, UMShareToQQ, UMShareToWechatSession, UMShareToWechatTimeline], delegate: nil)
        }
        let group3CellModel3 = JFSettingCellArrow(title: "版权/责任声明", icon: "setting_help_icon", destinationVc: JFDutyViewController.self)
        let group4CellModel4 = JFSettingCellLabel(title: "当前版本", icon: "setting_upload_icon", text: (NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String))
        let group3 = JFSettingGroup(cells: [group3CellModel1, group3CellModel2, group3CellModel3, group4CellModel4])
        
        groupModels = [group1, group2, group3]
        
    }
    
}
