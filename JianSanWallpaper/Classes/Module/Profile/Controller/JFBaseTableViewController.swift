//
//  JFBaseTableViewController.swift
//  JianSan Wallpaper
//
//  Created by zhoujianfeng on 16/4/27.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

class JFBaseTableViewController: UITableViewController {
    
    /// 组模型数组
    var groupModels: [JFSettingGroup]?
    
    init () {
        super.init(style: UITableViewStyle.Grouped)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: UITableViewStyle.Grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = BACKGROUND_COLOR
        tableView.sectionHeaderHeight = 0
        tableView.separatorStyle = .None
        tableView.contentInset = UIEdgeInsets(top: -15, left: 0, bottom: 0, right: 0)
        tableView.registerClass(JFSettingCell.self, forCellReuseIdentifier: "setting")
        
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return groupModels?.count ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupModels![section].cells?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("setting") as! JFSettingCell
        let groupModel = groupModels![indexPath.section]
        let cellModel = groupModel.cells![indexPath.row]
        cell.cellModel = cellModel
        cell.showLineView = !(indexPath.row == groupModel.cells!.count - 1)
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupModels![section].footerDescription
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return groupModels![section].headerDescription
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cellModel = groupModels![indexPath.section].cells![indexPath.row]
        
        // 如果有可执行代码就执行
        if cellModel.operation != nil {
            cellModel.operation!()
            return
        }
        
        // 如果是箭头类型就跳转控制器
        if cellModel .isKindOfClass(JFSettingCellArrow.self) {
            let cellArrow = cellModel as! JFSettingCellArrow
            
            /// 目标控制器类
            let destinationVcClass = cellArrow.destinationVc as! UIViewController.Type
            
            let destinationVc = destinationVcClass.init()
            destinationVc.title = cellArrow.title
            
            // 如果是收藏控制器 就设置标识
//            if destinationVcClass.isEqual(JFTableViewController) {
                print("是收藏控制器")
//                (destinationVc as! JFTableViewController).isStarVc = true
//            }
            
            navigationController?.pushViewController(destinationVc, animated: true)
        }
        
    }
}
