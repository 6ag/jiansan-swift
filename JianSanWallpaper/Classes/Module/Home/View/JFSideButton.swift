//
//  JFSideButton.swift
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/7/26.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

class JFSideButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = CGRectMake(33, 0, 22, 22)
        titleLabel?.frame = CGRectMake(0, 27, 86, 20)
        titleLabel?.textAlignment = .Center
    }

}
