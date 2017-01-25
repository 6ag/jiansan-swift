//
//  JFCategoryTopView.swift
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/7/24.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

protocol JFCategoryTopViewDelegate {
    func didTappedLeftBarButton()
}

class JFCategoryTopView: UIView {
    
    var delegate: JFCategoryTopViewDelegate?
    
    /**
     点击了左边导航按钮
     */
    @IBAction func didTappedLeftBarButton(_ sender: UIButton) {
        delegate?.didTappedLeftBarButton()
    }

    @IBOutlet weak var titleLabel: UILabel!
}
