//
//  JFProgressHUD.swift
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/4/29.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit
import SVProgressHUD

class JFProgressHUD: NSObject {
    
    class func setupHUD() {
        SVProgressHUD.setForegroundColor(UIColor.whiteColor())
        SVProgressHUD.setBackgroundColor(UIColor(white: 0.1, alpha: 0.8))
        SVProgressHUD.setFont(UIFont.boldSystemFontOfSize(16))
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Custom)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
    }
    
    class func showWithStatus(status: String) {
        SVProgressHUD.showWithStatus(status)
    }
    
    class func showInfoWithStatus(status: String) {
        SVProgressHUD.showInfoWithStatus(status)
    }
    
    class func showSuccessWithStatus(status: String) {
        SVProgressHUD.showSuccessWithStatus(status)
    }
    
    class func showErrorWithStatus(status: String) {
        SVProgressHUD.showErrorWithStatus(status)
    }
    
}
