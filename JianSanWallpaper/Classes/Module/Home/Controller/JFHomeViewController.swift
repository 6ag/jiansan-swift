//
//  JFHomeViewController.swift
//  JianSan Wallpaper
//
//  Created by zhoujianfeng on 16/4/26.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit
import YYWebImage

class JFHomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    /**
     准备视图
     */
    private func prepareUI() {
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(topView)
        view.addSubview(contentView)
        sideView.delegate = self
    }
    
    // MARK: - 懒加载
    /// 顶部导航栏 topView
    private lazy var topView: JFHomeTopView = {
        let topView = NSBundle.mainBundle().loadNibNamed("JFHomeTopView", owner: nil, options: nil).last as! JFHomeTopView
        topView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64)
        topView.delegate = self
        return topView
    }()
    
    /// 视图区域 contentView
    private lazy var contentView: UIScrollView = {
        let contentView = UIScrollView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        contentView.contentSize = CGSize(width: SCREEN_WIDTH * 2, height: 0)
        contentView.pagingEnabled = true
        contentView.bounces = false
        contentView.showsHorizontalScrollIndicator = false
        contentView.delegate = self
        
        let popularVc = JFPopularViewController()
        popularVc.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64)
        contentView.addSubview(popularVc.view)
        self.addChildViewController(popularVc)
        
        let categoryVc = JFCategoryViewController()
        categoryVc.view.frame = CGRect(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64)
        contentView.addSubview(categoryVc.view)
        self.addChildViewController(categoryVc)
        return contentView
    }()
    
    /// 侧边栏
    private lazy var sideView: JFSideView = {
        let sideView = JFSideView.makeSideView()
        return sideView
    }()
    
}

// MARK: - UIScrollViewDelegate
extension JFHomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if (scrollView.contentOffset.x >= SCREEN_WIDTH) {
            topView.didTappedCategoryButton()
        } else {
            topView.didTappedPopularButton()
        }
    }
}

// MARK: - JFHomeTopViewDelegate
extension JFHomeViewController: JFHomeTopViewDelegate {
    
    /**
     点击了热门选项
     */
    func didSelectedPopularButton() {
        contentView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    /**
     点击了分类选项
     */
    func didSelectedCategoryButton() {
        contentView.setContentOffset(CGPoint(x: SCREEN_WIDTH, y: 0), animated: true)
    }
    
    /**
     点击了导航栏左侧按钮 打开侧边栏
     */
    func didTappedLeftBarButton() {
        UIView.animateWithDuration(0.25) {
            self.sideView.show()
        }
    }
}

// MARK: - JFHomeTopViewDelegate
extension JFHomeViewController: JFSideViewDelegate {
    
    /**
     我的收藏
     */
    func didTappedMyCollectionButton() {
        navigationController?.pushViewController(JFCollectionViewController(), animated: true)
    }
    
    /**
     清理缓存
     */
    func didTappedCleanCacheButton() {
        
        let cache = "\(String(format: "%.2f", CGFloat(YYImageCache.sharedCache().diskCache.totalCost()) / 1024 / 1024))M"
        
        let alertController = UIAlertController(title: "\(cache) 缓存", message: "您真的要清理缓存吗？清理缓存同时会清理【我的收藏】中的数据。", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action) in
        }
        let confirmAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Destructive) { (action) in
            JFProgressHUD.showWithStatus("正在清理")
            YYImageCache.sharedCache().diskCache.removeAllObjectsWithBlock({
                JFProgressHUD.showSuccessWithStatus("清理成功")
            })
        }
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        presentViewController(alertController, animated: true) {}
        
    }
    
    /**
     意见反馈
     */
    func didTappedFeedbackButton() {
        navigationController?.pushViewController(JFFeedbackViewController(), animated: true)
    }
    
    /**
     分享推荐
     */
    func didTappedShareButton() {
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: nil, shareText: "这是一款剑三福利app，十二大门派海量剑三壁纸每日更新，小伙伴们快来试试吧！https://itunes.apple.com/cn/app/id1110293594", shareImage: nil, shareToSnsNames: [UMShareToSina, UMShareToQQ, UMShareToWechatSession, UMShareToWechatTimeline], delegate: nil)
    }
}
