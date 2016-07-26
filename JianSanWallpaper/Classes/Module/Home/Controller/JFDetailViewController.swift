//
//  JFDetailViewController.swift
//  JianSan Wallpaper
//
//  Created by jianfeng on 16/2/4.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit
import YYWebImage

class JFDetailViewController: UIViewController, JFContextSheetDelegate {
    
    enum ImageAction {
        case homeScreen // 主屏幕
        case lockScreen // 锁屏
        case both       // 壁纸和锁屏
        case photo      // 相册
    }
    
    /// 图片对象
    var model: JFWallPaperModel? {
        didSet {
            imageView.yy_setImageWithURL(NSURL(string: "\(BASE_URL)/\(model!.bigpath!)"),
                                         placeholder: YYImageCache.sharedCache().getImageForKey(model!.smallpath!),
                                         options: YYWebImageOptions.Progressive,
                                         completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        // 轻敲手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTappedView(_:)))
        view.addGestureRecognizer(tapGesture)
        
        // 下滑手势
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didDownSwipeView(_:)))
        swipeGesture.direction = .Down
        view.addGestureRecognizer(swipeGesture)
        
        // 别日狗
        performSelectorOnMainThread(#selector(dontSleep), withObject: nil, waitUntilDone: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade)
    }
    
    /**
     唤醒线程
     */
    func dontSleep() -> Void {
        print("起来吧，别日狗了")
    }
    
    /**
     view触摸事件
     */
    @objc private func didTappedView(gestureRecognizer: UITapGestureRecognizer) {
        if contextSheet.isShow {
            contextSheet.dismiss()
        } else {
            // 如果预览视图已经加载，则再次触摸是取消预览 感觉这个用户体验不好 注释掉
            //            if (scrollView.superview != nil) {
            //                scrollView.removeFromSuperview()
            //            } else {
            contextSheet.startWithGestureRecognizer(gestureRecognizer, inView: view)
            //            }
        }
        
    }
    
    /**
     下滑手势
     */
    @objc private func didDownSwipeView(gestureRecognizer: UISwipeGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - JFContextSheetDelegate
    func contextSheet(contextSheet: JFContextSheet, didSelectItemWithItemName itemName: String) {
        switch (itemName) {
        case "返回":
            dismissViewControllerAnimated(true, completion: nil)
            break
        case "预览":
            if (scrollView.superview == nil) {
                view.addSubview(scrollView)
            }
            break
        case "设定":
            let alertController = UIAlertController()
            
            let lockScreen = UIAlertAction(title: "设定锁定屏幕", style: UIAlertActionStyle.Default, handler: { (action) in
                JFWallPaperTool.shareInstance().saveAndAsScreenPhotoWithImage(self.imageView.image!, imageScreen: UIImageScreenLock, finished: { (success) in
                    if success {
                        JFProgressHUD.showSuccessWithStatus("设置成功")
                    } else {
                        JFProgressHUD.showInfoWithStatus("设置失败")
                    }
                })
            })
            
            let homeScreen = UIAlertAction(title: "设定主屏幕", style: UIAlertActionStyle.Default, handler: { (action) in
                JFWallPaperTool.shareInstance().saveAndAsScreenPhotoWithImage(self.imageView.image!, imageScreen: UIImageScreenHome, finished: { (success) in
                    if success {
                        JFProgressHUD.showSuccessWithStatus("设置成功")
                    } else {
                        JFProgressHUD.showInfoWithStatus("设置失败")
                    }
                })
            })
            
            let homeScreenAndLockScreen = UIAlertAction(title: "同时设定", style: UIAlertActionStyle.Default, handler: { (action) in
                JFWallPaperTool.shareInstance().saveAndAsScreenPhotoWithImage(self.imageView.image!, imageScreen: UIImageScreenBoth, finished: { (success) in
                    if success {
                        JFProgressHUD.showSuccessWithStatus("设置成功")
                    } else {
                        JFProgressHUD.showInfoWithStatus("设置失败")
                    }
                })
            })
            
            let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: { (action) in
                
            })
            
            // 添加动作
            alertController.addAction(lockScreen)
            alertController.addAction(homeScreen)
            alertController.addAction(homeScreenAndLockScreen)
            alertController.addAction(cancel)
            
            // 弹出选项
            presentViewController(alertController, animated: true, completion: {
                
            })
            
            break
        case "下载":
            UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            break
        case "收藏":
            JFFMDBManager.sharedManager.checkIsExists(model!.bigpath!, finished: { (isExists) in
                if isExists {
                    JFProgressHUD.showInfoWithStatus("已经收藏过了")
                } else {
                    JFFMDBManager.sharedManager.insertStar(self.model!.bigpath!)
                    JFProgressHUD.showSuccessWithStatus("收藏成功")
                }
            })
            break
        default:
            break
        }
    }
    
    /**
     保存图片到相册回调
     */
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if error != nil {
            JFProgressHUD.showErrorWithStatus("保存失败")
        } else {
            JFProgressHUD.showSuccessWithStatus("保存成功")
        }
        
    }
    
    // MARK: - 懒加载
    /// 展示的壁纸图片
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = SCREEN_BOUNDS
        self.view.addSubview(imageView)
        return imageView
    }()
    
    /// 触摸屏幕后弹出视图
    private lazy var contextSheet: JFContextSheet = {
        let contextItem1 = JFContextItem(itemName: "返回", itemIcon: "content_icon_back")
        let contextItem2 = JFContextItem(itemName: "预览", itemIcon: "content_icon_preview")
        let contextItem3 = JFContextItem(itemName: "设定", itemIcon: "content_icon_set")
        let contextItem4 = JFContextItem(itemName: "下载", itemIcon: "content_icon_download")
        let contextItem5 = JFContextItem(itemName: "收藏", itemIcon: "content_icon_star")
        
        // 选项数组
        var items = [contextItem1, contextItem2, contextItem3, contextItem4, contextItem5]
        
        if !(UIApplication.sharedApplication().delegate as! AppDelegate).on {
            items.removeAtIndex(2)
        }
        
        // 选项视图
        let contextSheet = JFContextSheet(items: items)
        contextSheet.delegate = self
        return contextSheet
    }()
    
    /// 预览滚动视图
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: SCREEN_BOUNDS)
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH * 2, height: SCREEN_HEIGHT)
        
        // 第一张背景
        let previewImage1 = UIImageView(image: UIImage(named: "preview_cover_clock"))
        previewImage1.frame = SCREEN_BOUNDS
        
        // 第二张背景
        let previewImage2 = UIImageView(image: UIImage(named: "preview_cover_home"))
        previewImage2.frame = CGRect(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        
        scrollView.addSubview(previewImage1)
        scrollView.addSubview(previewImage2)
        return scrollView
    }()
    
}
