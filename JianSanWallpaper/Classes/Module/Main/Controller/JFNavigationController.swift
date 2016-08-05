//
//  JFNavigationController.swift
//  JianSan Wallpaper
//
//  Created by jianfeng on 16/2/4.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

class JFNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置全局导航栏
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = NAVBAR_TINT_COLOR
        navBar.translucent = false
        navBar.barStyle = UIBarStyle.Black
        navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navBar.shadowImage = UIImage()
        navBar.titleTextAttributes = [
            NSForegroundColorAttributeName : TITLE_COLOR,
            NSFontAttributeName : TITLE_FONT
        ]
        
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "top_navigation_back")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(back))
        }
        
        // push放后面是为了控制器可以自己重新设置leftBarButtonItem并覆盖掉统一设置的
        super.pushViewController(viewController, animated: animated)
        
    }
    
    /**
     返回
     */
    @objc private func back() {
        popViewControllerAnimated(true)
    }
}
