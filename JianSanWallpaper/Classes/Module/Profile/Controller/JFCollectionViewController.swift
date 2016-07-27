//
//  JFCollectionViewController.swift
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/7/26.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit
import ZLSwipeableViewSwift
import YYWebImage

class JFCollectionViewController: UIViewController {
    
    /// 收藏数据
    var data = [[String : AnyObject]]()
    
    /// 当前角标
    var currentIndex = -1
    
    /// 卡片视图
    var swipeableView = ZLSwipeableView(frame: CGRect(x: 50, y: 10, width: SCREEN_WIDTH - 100, height: SCREEN_HEIGHT - 74))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "我的收藏"
        view.backgroundColor = BACKGROUND_COLOR
        view.clipsToBounds = true
        
        prepareUI()
        loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    /**
     下一张图片
     */
    func nextCardView() -> UIView? {
        currentIndex += 1
        currentIndex %= data.count
        return data[currentIndex]["imageView"] as! UIImageView
    }
    
    /**
     准备UI
     */
    private func prepareUI() {
        
        view.addSubview(swipeableView)
        
        // 点击了卡片
        swipeableView.didTap = {view, location in
            let detailVc = JFDetailViewController()
            let dict: [String : AnyObject] = [
                "bigpath" : self.data[view.tag]["path"]!
            ]
            let model = JFWallPaperModel(dict: dict)
            detailVc.model = model
            detailVc.transitioningDelegate = self
            detailVc.modalPresentationStyle = .Custom
            self.presentViewController(detailVc, animated: true) {}
        }
        
    }
    
    /**
     加载收藏数据
     */
    @objc private func loadData() {
        
        JFFMDBManager.sharedManager.getStarWallpaper { (result) in
            guard let result = result else {
                return
            }
            
            for (index, dict) in result.enumerate() {
                let imageView = UIImageView(image: YYImageCache.sharedCache().getImageForKey("\(BASE_URL)/\(dict["path"]!)"))
                imageView.frame = self.swipeableView.bounds
                imageView.contentMode = .ScaleAspectFit
                imageView.layer.shouldRasterize = true
                imageView.layer.rasterizationScale = UIScreen.mainScreen().scale
                imageView.tag = index
                
                self.data.append([
                    "imageView" : imageView,
                    "path" : dict["path"]!,
                    ])
            }
            
            // 有数据才加载
            if (self.data.count > 0) {
                self.swipeableView.nextView = {
                    return self.nextCardView()
                }
            }
            
        }
        
    }
    
}

// MARK: - 栏目管理自定义转场动画事件
extension JFCollectionViewController: UIViewControllerTransitioningDelegate {
    
    /**
     返回一个控制modal视图大小的对象
     */
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return JFWallpaperPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    /**
     返回一个控制器modal动画效果的对象
     */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return JFWallpaperModalAnimation()
    }
    
    /**
     返回一个控制dismiss动画效果的对象
     */
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return JFWallpaperDismissAnimation()
    }
    
}
