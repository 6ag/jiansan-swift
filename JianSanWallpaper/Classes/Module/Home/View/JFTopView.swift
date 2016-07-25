//
//  JFTopView.swift
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/7/24.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

protocol JFTopViewDelegate {
    func didSelectedPopularButton()
    func didSelectedCategoryButton()
    func didTappedLeftBarButton()
}

class JFTopView: UIView {
    
    var delegate: JFTopViewDelegate?
    
    /**
     点击了热门选项
     */
    @IBAction func didTappedPopularButton(sender: UIButton) {
        delegate?.didSelectedPopularButton()
        sender.selected = true
        categoryButton.selected = false
        UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.lineView.transform = CGAffineTransformMakeTranslation(0, 0)
            }) { (_) in
                
        }
        
    }

    /**
     点击了分类选项
     */
    @IBAction func didTappedCategoryButton(sender: UIButton) {
        delegate?.didSelectedCategoryButton()
        sender.selected = true
        popularButton.selected = false
        UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.lineView.transform = CGAffineTransformMakeTranslation(82, 0)
        }) { (_) in
            
        }
        
    }
    
    /**
     点击了左边导航按钮
     */
    @IBAction func didTappedLeftBarButton(sender: UIButton) {
        delegate?.didTappedLeftBarButton()
    }
    @IBOutlet weak var popularButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var lineView: UIView!

}
