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
    
    /// 分类id为0会根据浏览量倒序查询
    var category_id = 0
    
    let wallpaperIdentifier = "wallpaperCell"
    
    /// 分类标题
    var category_title = ""
    
    /// 当前页
    var currentPage = 1
    
    /// 壁纸模型数组
    var wallpaperArray = [JFWallPaperModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        
        // 配置上下拉刷新控件
        collectionView.mj_header = jf_setupHeaderRefresh(self, action: #selector(pulldownLoadData))
        collectionView.mj_footer = jf_setupFooterRefresh(self, action: #selector(pullupLoadData))
        
        collectionView.mj_header.beginRefreshing()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isStatusBarHidden = false
        
        // 分类则添加自定义导航栏
        if (category_id != 0) {
            view.addSubview(topView)
        }
        
    }
    
    /**
     准备视图
     */
    fileprivate func prepareUI() {
        
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
    }
    
    /**
     下拉加载最新
     */
    @objc fileprivate func pulldownLoadData() {
        currentPage = 1
        loadData(category_id, page: currentPage, method: .pullDown)
    }
    
    /**
     上拉加载更多
     */
    @objc fileprivate func pullupLoadData() {
        currentPage += 1
        loadData(category_id, page: currentPage, method: .pullUp)
    }
    
    /**
     加载壁纸数据
     */
    fileprivate func loadData(_ category_id: Int, page: Int, method: PullMethod) {
        
        JFWallPaperModel.loadWallpapersFromNetwork(category_id, page: page) { (wallpaperArray, error) in
            
            self.collectionView.mj_header.endRefreshing()
            self.collectionView.mj_footer.endRefreshing()
            
            guard let wallpaperArray = wallpaperArray, error == nil else {
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
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1.5
        layout.minimumLineSpacing = 1.5
        layout.itemSize = CGSize(width: (SCREEN_WIDTH - 3) / 3, height: (SCREEN_HEIGHT - STATUS_AND_NAVBAR_HEIGHT) / 2.71)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        if (self.category_id != 0) {
            // 隐藏导航栏后，从44开始
            collectionView.frame = CGRect(x: 0, y: STATUS_AND_NAVBAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - STATUS_AND_NAVBAR_HEIGHT)
        } else {
            collectionView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - STATUS_AND_NAVBAR_HEIGHT)
        }
        
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "JFWallpaperCell", bundle: nil), forCellWithReuseIdentifier: self.wallpaperIdentifier)
        return collectionView
    }()
    
    /// 顶部导航栏 topView
    lazy var topView: JFCategoryTopView = {
        let topView = Bundle.main.loadNibNamed("JFCategoryTopView", owner: nil, options: nil)?.last as! JFCategoryTopView
        topView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: STATUS_AND_NAVBAR_HEIGHT)
        topView.delegate = self
        topView.titleLabel.text = self.category_title
        return topView
    }()
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension JFPopularViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallpaperArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: wallpaperIdentifier, for: indexPath) as! JFWallpaperCell
        item.model = wallpaperArray[indexPath.item]
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 弹出插页广告
        if let interstitial = JFAdManager.shared.getReadyIntersitial() {
            interstitial.present(fromRootViewController: self)
            return
        }
        
        // 转换坐标系
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: wallpaperIdentifier, for: indexPath) as! JFWallpaperCell
        let rect = item.convert(item.frame, to: view)
        
        // 计算item相对于窗口的frame
        let x = rect.origin.x / 2
        let y = 64 + CGFloat(indexPath.item / 3) * rect.size.height - collectionView.contentOffset.y
        let width = rect.size.width
        let height = rect.size.height
        
        // 临时放大动画的图片
        let tempView = UIImageView()
        UIApplication.shared.keyWindow?.insertSubview(tempView, aboveSubview: view)
        
        // 分类页面需要下移20
        if (category_id == 0) {
            tempView.frame = CGRect(x: x, y: y, width: width, height: height)
        } else {
            tempView.frame = CGRect(x: x, y: y - 20, width: width, height: height)
        }
        
        tempView.setImage(urlString: "\(BASE_URL)/\(wallpaperArray[indexPath.item].smallpath!)", placeholderImage: UIImage(named: "placeholder"))
        
        // 放大动画并移除
        UIView.animate(withDuration: 0.3, animations: {
            tempView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        }, completion: { [weak self] (_) in
            // 自定义转场动画
            let detailVc = JFDetailViewController()
            detailVc.model = self?.wallpaperArray[indexPath.item]
            detailVc.tempView = tempView
            detailVc.transitioningDelegate = self
            detailVc.modalPresentationStyle = .custom
            self?.present(detailVc, animated: true) {
                DispatchQueue.global().async {
                    JFWallPaperModel.showWallpaper(self?.wallpaperArray[indexPath.item].id ?? 0, finished: { (wallpaper, error) in
                        print("这很nice，和很清真")
                    })
                }
                
            }
        })
        
    }
    
}

// MARK: - JFCategoryTopViewDelegate
extension JFPopularViewController: JFCategoryTopViewDelegate {
    
    /**
     点击了导航栏左侧按钮
     */
    func didTappedLeftBarButton() {
        _ = navigationController?.popViewController(animated: true)
    }
}

// MARK: - 栏目管理自定义转场动画事件
extension JFPopularViewController: UIViewControllerTransitioningDelegate {
    
    /**
     返回一个控制modal视图大小的对象
     */
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return JFWallpaperPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    /**
     返回一个控制器modal动画效果的对象
     */
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return JFWallpaperModalAnimation()
    }
    
    /**
     返回一个控制dismiss动画效果的对象
     */
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return JFWallpaperDismissAnimation()
    }
    
}
