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
        imageView?.frame = CGRect(x: 33, y: 0, width: 22, height: 22)
        titleLabel?.frame = CGRect(x: 0, y: 27, width: 86, height: 20)
        titleLabel?.textAlignment = .center
    }

}
