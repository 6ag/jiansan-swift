//
//  JFPopularViewController.swift
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/7/23.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit
import MJRefresh

class JFPopularViewController: UIViewController {
    
    let wallpaperIdentifier = "wallpaperCell"
    
    /// 分类id为0会根据浏览量倒序查询
    var category_id = 0
    
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
    
    /**
     准备视图
     */
    private func prepareUI() {
        
        view.backgroundColor = UIColor.yellowColor()
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
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(UINib(nibName: "JFWallpaperCell", bundle: nil), forCellWithReuseIdentifier: self.wallpaperIdentifier)
        return collectionView
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
        print(indexPath.item)
    }

}
