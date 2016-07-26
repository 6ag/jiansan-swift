//
//  JFCategoryViewController.swift
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/7/23.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit
import SnapKit

class JFCategoryViewController: UIViewController {

    let categoryIdentifier = "categoryCell"
    
    var categoriesArray = [JFCategoryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        loadCategoryData()
    }
    
    /**
     准备视图
     */
    private func prepareUI() {
        
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(collectionView)
        view.addSubview(popularButton)
        view.addSubview(bestButton)
        
        popularButton.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(collectionView.snp_bottom).offset(1.5)
            make.height.equalTo((SCREEN_HEIGHT - 64 - ((SCREEN_HEIGHT - 64) / 4.6)) / 2)
        }
        
        bestButton.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(popularButton.snp_bottom).offset(1.5)
            make.height.equalTo(popularButton)
        }
    }
    
    /**
     加载分类数据
     */
    @objc private func loadCategoryData() {
        JFCategoryModel.loadCategoriesFromNetwork { (categoriesArray, error) in
            guard let categoriesArray = categoriesArray where error == nil else {
                return
            }
            
            self.categoriesArray = categoriesArray
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - 懒加载
    /// collectionView
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1.5
        layout.minimumLineSpacing = 1.5
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSize(width: (SCREEN_WIDTH - 4.5) / 4, height: (SCREEN_HEIGHT - 64) / 4.6)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: (SCREEN_HEIGHT - 64) / 4.6), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerNib(UINib(nibName: "JFCategoryCell", bundle: nil), forCellWithReuseIdentifier: self.categoryIdentifier)
        return collectionView
    }()
    
    /// 热门
    private lazy var popularButton: UIButton = {
        let popularButton = UIButton(type: .Custom)
        popularButton.setBackgroundImage(UIImage(named: "category_popular"), forState: UIControlState.Normal)
        return popularButton
    }()
    
    /// 最佳锁屏
    private lazy var bestButton: UIButton = {
        let bestButton = UIButton(type: .Custom)
        bestButton.setBackgroundImage(UIImage(named: "category_best"), forState: UIControlState.Normal)
        return bestButton
    }()
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension JFCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCellWithReuseIdentifier(categoryIdentifier, forIndexPath: indexPath) as! JFCategoryCell
        item.model = categoriesArray[indexPath.item]
        return item
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let popularVc = JFPopularViewController()
        popularVc.category_id = categoriesArray[indexPath.item].id
        popularVc.category_title = categoriesArray[indexPath.item].name!
        navigationController?.pushViewController(popularVc, animated: true)
    }
    
    
}