//
//  JFSideView.swift
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/7/26.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

protocol JFSideViewDelegate {
    func didTappedMyCollectionButton()
    func didTappedCleanCacheButton()
    func didTappedFeedbackButton()
    func didTappedShareButton()
}

class JFSideView: UIView {
    
    var delegate: JFSideViewDelegate?
    
    /// 遮罩按钮
    private lazy var shadowButton: UIButton = {
        let shadowButton = UIButton(frame: SCREEN_BOUNDS)
        shadowButton.backgroundColor = UIColor(white: 1, alpha: 0)
        shadowButton.addTarget(self, action: #selector(didTappedShadowButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return shadowButton
    }()
    
    /**
     创建侧边栏
     
     - returns: 返回创建好的侧边栏
     */
    class func makeSideView() -> JFSideView {
        let sideView = NSBundle.mainBundle().loadNibNamed("JFSideView", owner: nil, options: nil).last as! JFSideView
        sideView.layer.shadowOffset = CGSize(width: 2, height: 1)
        sideView.layer.shadowColor = UIColor.blackColor().CGColor
        sideView.layer.shadowOpacity = 0.3
        sideView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 84, y: 0, width: 2, height: SCREEN_HEIGHT)).CGPath
        sideView.frame = CGRect(x: -86, y: 0, width: 85, height: SCREEN_HEIGHT)
        return sideView
    }
    
    /**
     显示侧边栏
     */
    func show() {
        UIApplication.sharedApplication().keyWindow?.addSubview(shadowButton)
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        
        self.alpha = 1
        UIView.animateWithDuration(0.25, animations: {
            self.transform = CGAffineTransformMakeTranslation(86, 0)
            self.shadowButton.alpha = 0.1
            }) { (_) in
                
        }
    }
    
    /**
     隐藏侧边栏
     */
    func dismiss() {
        UIView.animateWithDuration(0.25, animations: { 
            self.transform = CGAffineTransformIdentity
            self.alpha = 0
            self.shadowButton.alpha = 0
            }) { (_) in
                self.removeFromSuperview()
                self.shadowButton.removeFromSuperview()
        }
    }
    
    /**
     点击了遮罩
     */
    @objc private func didTappedShadowButton(button: UIButton) {
        dismiss()
    }
    
    /**
     我的收藏
     */
    @IBAction func didTappedMyCollectionButton(sender: JFSideButton) {
        dismiss()
        delegate?.didTappedMyCollectionButton()
    }
    
    /**
     清理缓存
     */
    @IBAction func didTappedCleanCacheButton(sender: JFSideButton) {
        dismiss()
        delegate?.didTappedCleanCacheButton()
    }
    
    /**
     反馈
     */
    @IBAction func didTappedFeedbackButton(sender: JFSideButton) {
        dismiss()
        delegate?.didTappedFeedbackButton()
    }
    
    /**
     分享
     */
    @IBAction func didTappedShareButton(sender: JFSideButton) {
        dismiss()
        delegate?.didTappedShareButton()
    }

}
