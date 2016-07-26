//
//  JFCollectionViewController.swift
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/7/26.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

class JFCollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "我的收藏"
        view.backgroundColor = BACKGROUND_COLOR
        
        loadData()
    }
    
    @objc private func loadData() {
        
        JFFMDBManager.sharedManager.getStarWallpaper { (result) in
            print(result)
        }
    }

}
