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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    /**
     准备视图
     */
    fileprivate func prepareUI() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(topView)
        view.addSubview(contentView)
        sideView.delegate = self
    }
    
    // MARK: - 懒加载
    /// 顶部导航栏 topView
    fileprivate lazy var topView: JFHomeTopView = {
        let topView = Bundle.main.loadNibNamed("JFHomeTopView", owner: nil, options: nil)?.last as! JFHomeTopView
        topView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: STATUS_AND_NAVBAR_HEIGHT)
        topView.delegate = self
        return topView
    }()
    
    /// 视图区域 contentView
    fileprivate lazy var contentView: UIScrollView = {
        let contentView = UIScrollView(frame: CGRect(x: 0, y: STATUS_AND_NAVBAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - STATUS_AND_NAVBAR_HEIGHT))
        contentView.contentSize = CGSize(width: SCREEN_WIDTH * 2, height: 0)
        contentView.isPagingEnabled = true
        contentView.bounces = false
        contentView.showsHorizontalScrollIndicator = false
        contentView.delegate = self
        
        let popularVc = JFPopularViewController()
        popularVc.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64)
        contentView.addSubview(popularVc.view)
        self.addChildViewController(popularVc)
        
        let categoryVc = JFCategoryViewController()
        categoryVc.delegate = self
        categoryVc.view.frame = CGRect(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64)
        contentView.addSubview(categoryVc.view)
        self.addChildViewController(categoryVc)
        return contentView
    }()
    
    /// 侧边栏
    fileprivate lazy var sideView: JFSideView = {
        let sideView = JFSideView.makeSideView()
        return sideView
    }()
    
}

// MARK: - UIScrollViewDelegate
extension JFHomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
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
        UIView.animate(withDuration: 0.25, animations: {
            self.sideView.show()
        }) 
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
        
        let cache = "\(String(format: "%.2f", CGFloat(YYImageCache.shared().diskCache.totalCost()) / 1024 / 1024))M"
        
        let alertController = UIAlertController(title: "\(cache) 缓存", message: "您真的要清理缓存吗？清理缓存同时会清理【我的收藏】中的数据。", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (action) in
        }
        let confirmAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.destructive) { (action) in
            JFProgressHUD.showWithStatus("正在清理")
            // 移除全部收藏
            JFFMDBManager.sharedManager.removeAllStarWallpapaer()
            YYImageCache.shared().diskCache.removeAllObjects({
                JFProgressHUD.showSuccessWithStatus("清理成功")
            })
        }
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        present(alertController, animated: true) {}
        
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
        
    }
}

// MARK: - JFCategoryViewControllerDelegate
extension JFHomeViewController: JFCategoryViewControllerDelegate {
    
    func didTappedPopularButton() {
        self.topView.didTappedPopularButton()
    }
    func didTappedBestButton() {
        self.topView.didTappedPopularButton()
    }
}
