//
//  JFCategoryViewController.swift
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/7/23.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit
import SnapKit

protocol JFCategoryViewControllerDelegate {
    func didTappedPopularButton()
    func didTappedBestButton()
}

class JFCategoryViewController: UIViewController {

    let categoryIdentifier = "categoryCell"
    
    var categoriesArray = [JFCategoryModel]()
    
    var delegate: JFCategoryViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        loadCategoryData()
    }
    
    /**
     准备视图
     */
    fileprivate func prepareUI() {
        
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        view.addSubview(popularButton)
        view.addSubview(bestButton)
        
        popularButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(collectionView.snp.bottom).offset(1.5)
            make.height.equalTo((SCREEN_HEIGHT - 64 - ((SCREEN_HEIGHT - 64) / 4.6)) / 2)
        }
        
        bestButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(popularButton.snp.bottom).offset(1.5)
            make.height.equalTo(popularButton)
        }
    }
    
    /**
     加载分类数据
     */
    @objc fileprivate func loadCategoryData() {
        JFCategoryModel.loadCategoriesFromNetwork { (categoriesArray, error) in
            guard let categoriesArray = categoriesArray, error == nil else {
                return
            }
            
            self.categoriesArray = categoriesArray
            self.collectionView.reloadData()
        }
    }
    
    /**
     点击了热门
     */
    @objc fileprivate func didTappedPopularButton(_ button: UIButton) {
        delegate?.didTappedPopularButton()
    }
    
    /**
     点击了最佳锁屏
     */
    @objc fileprivate func didTappedBestButton(_ button: UIButton) {
        delegate?.didTappedBestButton()
    }
    
    // MARK: - 懒加载
    /// collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1.5
        layout.minimumLineSpacing = 1.5
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (SCREEN_WIDTH - 4.5) / 4, height: (SCREEN_HEIGHT - 64) / 4.6)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: (SCREEN_HEIGHT - 64) / 4.6), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: "JFCategoryCell", bundle: nil), forCellWithReuseIdentifier: self.categoryIdentifier)
        return collectionView
    }()
    
    /// 热门
    fileprivate lazy var popularButton: UIButton = {
        let popularButton = UIButton(type: .custom)
        popularButton.setBackgroundImage(UIImage(named: "category_popular"), for: UIControlState())
        popularButton.addTarget(self, action: #selector(didTappedPopularButton(_:)), for: UIControlEvents.touchUpInside)
        return popularButton
    }()
    
    /// 最佳锁屏
    fileprivate lazy var bestButton: UIButton = {
        let bestButton = UIButton(type: .custom)
        bestButton.setBackgroundImage(UIImage(named: "category_best"), for: UIControlState())
        bestButton.addTarget(self, action: #selector(didTappedBestButton(_:)), for: UIControlEvents.touchUpInside)
        return bestButton
    }()
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension JFCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: categoryIdentifier, for: indexPath) as! JFCategoryCell
        item.model = categoriesArray[indexPath.item]
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let popularVc = JFPopularViewController()
        popularVc.category_id = categoriesArray[indexPath.item].id
        popularVc.category_title = categoriesArray[indexPath.item].name ?? ""
        navigationController?.pushViewController(popularVc, animated: true)
    }
}
