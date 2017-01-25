//
//  JFTipView.swift
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/8/13.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

class JFTipView: UIView {
    
    let bgView = UIView(frame: SCREEN_BOUNDS) // 透明遮罩
    let swipeImageView = UIImageView()
    let swipeLabel = UILabel()
    
    /**
     弹出视图
     */
    func show() {
        bgView.backgroundColor = UIColor(white: 0, alpha: 0)
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedBgView(_:))))
        UIApplication.shared.keyWindow?.addSubview(bgView)
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        swipeImageView.image = UIImage(named: "swipe_down")
        swipeImageView.frame = CGRect(x: 100, y: SCREEN_HEIGHT - 200, width: 50, height: 50)
        UIApplication.shared.keyWindow?.addSubview(swipeImageView)
        
        swipeLabel.text = "可以下滑返回哦"
        swipeLabel.font = UIFont.boldSystemFont(ofSize: 18)
        swipeLabel.textColor = UIColor.white
        swipeLabel.frame = CGRect(x: 160, y: SCREEN_HEIGHT - 180, width: SCREEN_WIDTH - 160, height: 30)
        UIApplication.shared.keyWindow?.addSubview(swipeLabel)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.bgView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        }, completion: { (_) in
            self.showAnimation(2)
        }) 
        
    }
    
    /**
     下滑手势动画
     */
    fileprivate func showAnimation(_ count: Int) {
        var animationCount = count
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
            self.swipeImageView.transform = CGAffineTransform(translationX: 0, y: 100)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                    self.swipeImageView.transform = CGAffineTransform.identity
                    }, completion: { (_) in
                        animationCount -= 1
                        if animationCount > 0 {
                            self.showAnimation(animationCount)
                        }
                })
                
        })
    }
    
    /**
     隐藏视图
     */
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: {
            self.swipeImageView.alpha = 0
            self.swipeLabel.alpha = 0
            self.bgView.backgroundColor = UIColor(white: 0, alpha: 0)
        }, completion: { (_) in
            self.bgView.removeFromSuperview()
            self.swipeImageView.removeFromSuperview()
            self.swipeLabel.removeFromSuperview()
            self.removeFromSuperview()
        }) 
    }
    
    /**
     透明背景遮罩触摸事件
     */
    @objc fileprivate func didTappedBgView(_ tap: UITapGestureRecognizer) {
        dismiss()
    }
    
}
