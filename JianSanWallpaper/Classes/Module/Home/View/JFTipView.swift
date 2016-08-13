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
        UIApplication.sharedApplication().keyWindow?.addSubview(bgView)
        
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        
        swipeImageView.image = UIImage(named: "swipe_down")
        swipeImageView.frame = CGRect(x: 100, y: SCREEN_HEIGHT - 200, width: 50, height: 50)
        UIApplication.sharedApplication().keyWindow?.addSubview(swipeImageView)
        
        swipeLabel.text = "可以下滑返回哦"
        swipeLabel.font = UIFont.boldSystemFontOfSize(18)
        swipeLabel.textColor = UIColor.whiteColor()
        swipeLabel.frame = CGRect(x: 160, y: SCREEN_HEIGHT - 180, width: SCREEN_WIDTH - 160, height: 30)
        UIApplication.sharedApplication().keyWindow?.addSubview(swipeLabel)
        
        UIView.animateWithDuration(0.25, animations: {
            self.bgView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        }) { (_) in
            self.showAnimation(2)
        }
        
    }
    
    /**
     下滑手势动画
     */
    private func showAnimation(count: Int) {
        var animationCount = count
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            self.swipeImageView.transform = CGAffineTransformMakeTranslation(0, 100)
            }, completion: { (_) in
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    self.swipeImageView.transform = CGAffineTransformIdentity
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
        UIView.animateWithDuration(0.25, animations: {
            self.swipeImageView.alpha = 0
            self.swipeLabel.alpha = 0
            self.bgView.backgroundColor = UIColor(white: 0, alpha: 0)
        }) { (_) in
            self.bgView.removeFromSuperview()
            self.swipeImageView.removeFromSuperview()
            self.swipeLabel.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
    /**
     透明背景遮罩触摸事件
     */
    @objc private func didTappedBgView(tap: UITapGestureRecognizer) {
        dismiss()
    }
    
}
