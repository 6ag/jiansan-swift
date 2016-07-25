//
//  JFDutyViewController.swift
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/4/29.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit
import SnapKit

class JFDutyViewController: JFBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textColor = UIColor(red:0.500,  green:0.500,  blue:0.500, alpha:1)
        let textFont = UIFont.systemFontOfSize(14)

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        headerView.backgroundColor = BACKGROUND_COLOR
        tableView.tableHeaderView = headerView
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -500, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: 0)
        
        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.textColor = textColor
        messageLabel.font = textFont
        messageLabel.text = "   剑三壁纸库本身是完全免费的，且所有壁纸资源均为原创或网友分享，下载和使用本软件过程中产生的网络数据流量费用，均由运营商收取。任何问题可以通过如下方式联系到APP作者。"
        headerView.addSubview(messageLabel)
        
        let qqLabel = UILabel()
        qqLabel.textColor = textColor
        qqLabel.font = textFont
        qqLabel.text = "   作者QQ: 44334512"
        headerView.addSubview(qqLabel)
        
        let blogLabel = UILabel()
        blogLabel.textColor = textColor
        blogLabel.font = textFont
        blogLabel.text = "   作者博客: https://blog.6ag.cn"
        headerView.addSubview(blogLabel)
        
        let emailLabel = UILabel()
        emailLabel.textColor = textColor
        emailLabel.font = textFont
        emailLabel.text = "   作者Email: admin@6ag.cn"
        headerView.addSubview(emailLabel)
        
        messageLabel.snp_makeConstraints { (make) in
            make.top.left.equalTo(MARGIN)
            make.right.equalTo(-MARGIN)
        }
        
        blogLabel.snp_makeConstraints { (make) in
            make.left.equalTo(messageLabel)
            make.top.equalTo(messageLabel.snp_bottom).offset(MARGIN)
        }
        
        qqLabel.snp_makeConstraints { (make) in
            make.left.equalTo(messageLabel)
            make.top.equalTo(blogLabel.snp_bottom).offset(MARGIN)
        }
        
        emailLabel.snp_makeConstraints { (make) in
            make.left.equalTo(messageLabel)
            make.top.equalTo(qqLabel.snp_bottom).offset(MARGIN)
        }
        
    }

}
