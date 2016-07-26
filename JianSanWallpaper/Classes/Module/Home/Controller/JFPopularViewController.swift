//
//  JFPopularViewController.swift
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/7/23.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit
import MJRefresh
import YYWebImage

class JFPopularViewController: UIViewController {
    
    let wallpaperIdentifier = "wallpaperCell"
    
    /// 分类id为0会根据浏览量倒序查询
    var category_id = 0
    
    /// 分类标题
    var category_title = ""
    
    /// 当前页
    var currentPage = 1
    
    /// 壁纸模型数组
    var wallpaperArray = [JFWallPaperModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        pulldownLoadData()
        
        // 配置上下拉刷新控件
        collectionView.mj_header = jf_setupHeaderRefresh(self, action: #selector(pulldownLoadData))
        collectionView.mj_footer = jf_setupFooterRefresh(self, action: #selector(pullupLoadData))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarHidden = false
        
        // 分类则添加自定义导航栏
        if (category_id != 0) {
            view.addSubview(topView)
        }
    }
    
    /**
     准备视图
     */
    private func prepareUI() {
        
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(collectionView)
    }
    
    /**
     下拉加载最新
     */
    @objc private func pulldownLoadData() {
        currentPage = 1
        loadData(category_id, page: currentPage, method: .pullDown)
    }
    
    /**
     上拉加载更多
     */
    @objc private func pullupLoadData() {
        currentPage += 1
        loadData(category_id, page: currentPage, method: .pullUp)
    }
    
    /**
     加载壁纸数据
     */
    private func loadData(category_id: Int, page: Int, method: PullMethod) {
        
        JFWallPaperModel.loadWallpapersFromNetwork(category_id, page: page) { (wallpaperArray, error) in
            
            self.collectionView.mj_header.endRefreshing()
            self.collectionView.mj_footer.endRefreshing()
            
            guard let wallpaperArray = wallpaperArray where error == nil else {
                return
            }
            
            if (wallpaperArray.count == 0) {
                self.collectionView.mj_footer.endRefreshingWithNoMoreData()
                return
            }
            
            if (method == .pullUp) {
                self.wallpaperArray += wallpaperArray
            } else {
                self.wallpaperArray = wallpaperArray
            }
            
            self.collectionView.reloadData()
        }
        
    }
    
    // MARK: - 懒加载
    /// collectionView
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1.5
        layout.minimumLineSpacing = 1.5
        layout.itemSize = CGSize(width: (SCREEN_WIDTH - 3) / 3, height: (SCREEN_HEIGHT - 64) / 2.71)
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        
        if (self.category_id != 0) {
            // 隐藏导航栏后，从44开始
            collectionView.frame = CGRect(x: 0, y: 44, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 44)
        } else {
            collectionView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64)
        }
        
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(UINib(nibName: "JFWallpaperCell", bundle: nil), forCellWithReuseIdentifier: self.wallpaperIdentifier)
        return collectionView
    }()
    
    /// 顶部导航栏 topView
    lazy var topView: JFCategoryTopView = {
        let topView = NSBundle.mainBundle().loadNibNamed("JFCategoryTopView", owner: nil, options: nil).last as! JFCategoryTopView
        topView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64)
        topView.delegate = self
        topView.titleLabel.text = self.category_title
        return topView
    }()
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension JFPopularViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallpaperArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCellWithReuseIdentifier(wallpaperIdentifier, forIndexPath: indexPath) as! JFWallpaperCell
        item.model = wallpaperArray[indexPath.item]
        return item
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let item = collectionView.dequeueReusableCellWithReuseIdentifier(wallpaperIdentifier, forIndexPath: indexPath) as! JFWallpaperCell
        let rect = item.convertRect(item.frame, toView: view)
        
        let x = rect.origin.x / 2
        let y = 64 + CGFloat(indexPath.item / 3) * rect.size.height - collectionView.contentOffset.y
        let width = rect.size.width
        let height = rect.size.height
        
        let tempView = UIImageView(image: YYImageCache.sharedCache().getImageForKey("\(BASE_URL)/\(wallpaperArray[indexPath.item].smallpath!)"))
        tempView.frame = CGRect(x: x, y: y, width: width, height: height)
        UIApplication.sharedApplication().keyWindow?.insertSubview(tempView, aboveSubview: view)
        
        UIView.animateWithDuration(0.25, animations: {
            tempView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
            }) { (_) in
                UIView.animateWithDuration(0.4, animations: {
                    tempView.alpha = 0
                    }, completion: { (_) in
                        tempView.removeFromSuperview()
                })
        }
        
        let detailVc = JFDetailViewController()
        detailVc.model = wallpaperArray[indexPath.item]
        detailVc.transitioningDelegate = self
        detailVc.modalPresentationStyle = .Custom
        presentViewController(detailVc, animated: true) {
            // 异步更新浏览量
            dispatch_async(dispatch_get_global_queue(0, 0), {
                JFWallPaperModel.showWallpaper(self.wallpaperArray[indexPath.item].id, finished: { (wallpaper, error) in
                    print("这很nice，和很清真")
                })
            })
        }
    }

}

// MARK: - JFCategoryTopViewDelegate
extension JFPopularViewController: JFCategoryTopViewDelegate {
    
    /**
     点击了导航栏左侧按钮
     */
    func didTappedLeftBarButton() {
        navigationController?.popViewControllerAnimated(true)
    }
}

// MARK: - 栏目管理自定义转场动画事件
extension JFPopularViewController: UIViewControllerTransitioningDelegate {
    
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
