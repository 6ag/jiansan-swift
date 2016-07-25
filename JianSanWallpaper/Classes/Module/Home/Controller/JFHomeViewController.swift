//
//  JFHomeViewController.swift
//  JianSan Wallpaper
//
//  Created by zhoujianfeng on 16/4/26.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

class JFHomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    /**
     准备视图
     */
    private func prepareUI() {
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(topView)
        view.addSubview(contentView)
    }
    
    // MARK: - 懒加载
    /// 顶部导航栏 topView
    lazy var topView: JFTopView = {
        let topView = NSBundle.mainBundle().loadNibNamed("JFTopView", owner: nil, options: nil).last as! JFTopView
        topView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64)
        return topView
    }()
    
    /// 视图区域 contentView
    lazy var contentView: UIScrollView = {
        let contentView = UIScrollView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        contentView.contentSize = CGSize(width: SCREEN_WIDTH * 2, height: 0)
        contentView.pagingEnabled = true
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
    
    
}

// MARK: - UIScrollViewDelegate
extension JFHomeViewController: UIScrollViewDelegate {
    
}
