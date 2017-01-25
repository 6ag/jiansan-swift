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
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor(white: 0.1, alpha: 0.8))
        SVProgressHUD.setFont(UIFont.boldSystemFont(ofSize: 16))
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.custom)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
    }
    
    class func showWithStatus(_ status: String) {
        SVProgressHUD.show(withStatus: status)
    }
    
    class func showInfoWithStatus(_ status: String, minimumDismissTimeInterval: TimeInterval = 1.0) {
        SVProgressHUD.setMinimumDismissTimeInterval(minimumDismissTimeInterval)
        SVProgressHUD.showInfo(withStatus: status)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
    }
    
    class func showSuccessWithStatus(_ status: String) {
        SVProgressHUD.showSuccess(withStatus: status)
    }
    
    class func showErrorWithStatus(_ status: String) {
        SVProgressHUD.showError(withStatus: status)
    }
    
}
