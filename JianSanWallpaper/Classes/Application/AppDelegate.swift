//
//  AppDelegate.swift
//  JianSan Wallpaper
//
//  Created by jianfeng on 16/2/4.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var on = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupGlobalStyle()      // 设置全局样式
        loadViewController()    // 加载视图控制器
        setupSaveWallPaper()    // 设置保存壁纸
        checkShowShare()        // 检查是否能够显示分享
        setupUSharePlatforms()  // 设置分享sdk
        setupMobClick()         // 设置友盟统计
        setupADManager()        // 设置广告管理者
        
        return true
    }
    
    /// 检查是否需要弹出分享
    fileprivate func checkShowShare() {
        
        // 如果正在更新版本中，则隐藏功能
        JFAppStoreApp.getAppStoreApp { (app, isUpdatingVersion) in
            if let app = app {
                UserDefaults.standard.set(isUpdatingVersion, forKey: "isUpdatingVersion")
                print("app.version = \(app.version ?? "")")
            } else {
                // 请求出了问题，为了防止意外，也当成正在更新版本中
                UserDefaults.standard.set(true, forKey: "isUpdatingVersion")
            }
        }
        
    }
    
    /// 初始化友盟分享
    fileprivate func setupUSharePlatforms() {
        
        UMSocialManager.default().openLog(false)
        UMSocialGlobal.shareInstance().isUsingHttpsWhenShareContent = true
        
        // 设置友盟appKey
        UMSocialManager.default().umSocialAppkey = UM_APP_KEY
        
        // 微信聊天
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatSession, appKey: WX_APP_ID, appSecret: WX_APP_SECRET, redirectURL: "http://mobile.umeng.com/social")
        
        // 微信收藏
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatFavorite, appKey: WX_APP_ID, appSecret: WX_APP_SECRET, redirectURL: "http://mobile.umeng.com/social")
        
        // 微信朋友圈
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatTimeLine, appKey: WX_APP_ID, appSecret: WX_APP_SECRET, redirectURL: "http://mobile.umeng.com/social")
        
        // 腾讯
        UMSocialManager.default().setPlaform(UMSocialPlatformType.QQ, appKey: QQ_APP_ID, appSecret: nil, redirectURL: "http://mobile.umeng.com/social")
        
        // 新浪
        UMSocialManager.default().setPlaform(UMSocialPlatformType.sina, appKey: WB_APP_KEY, appSecret: WB_APP_SECRET, redirectURL: "https://blog.6ag.cn")
        
    }
    
    /// 初始化友盟统计
    fileprivate func setupMobClick() {
        let config = UMAnalyticsConfig.sharedInstance()
        config?.appKey = UM_APP_KEY
        config?.channelId = "App Store"
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        MobClick.setAppVersion(currentVersion)
        MobClick.start(withConfigure: config)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let result = UMSocialManager.default().handleOpen(url)
        if result {
            
        }
        return result
    }
    
    /// 初始化广告管理者
    fileprivate func setupADManager() {
        JFAdConfiguration.shared.config(
            applicationId: "ca-app-pub-3941303619697740~9852864912",
            interstitialId: "ca-app-pub-3941303619697740/9066705318",
            bannerId: "ca-app-pub-3941303619697740/2329598119",
            timeInterval: 120)
    }

    /**
     配置保存壁纸选项
     */
    fileprivate func setupSaveWallPaper() {
        JFNetworkTools.shareNetworkTools.checkSaveState { (on) in
            self.on = on
            JFWallPaperTool.shareInstance().on = on
        }
    }
    
    /**
     配置全局样式
     */
    fileprivate func setupGlobalStyle() {
        
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        JFProgressHUD.setupHUD()
    }
    
    /**
     加载默认根控制器
     */
    fileprivate func loadViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = JFNavigationController(rootViewController: JFHomeViewController())
        window?.makeKeyAndVisible()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

