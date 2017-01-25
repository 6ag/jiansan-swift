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
    fileprivate lazy var shadowButton: UIButton = {
        let shadowButton = UIButton(frame: SCREEN_BOUNDS)
        shadowButton.backgroundColor = UIColor(white: 1, alpha: 0)
        shadowButton.addTarget(self, action: #selector(didTappedShadowButton(_:)), for: UIControlEvents.touchUpInside)
        return shadowButton
    }()
    
    /**
     创建侧边栏
     
     - returns: 返回创建好的侧边栏
     */
    class func makeSideView() -> JFSideView {
        let sideView = Bundle.main.loadNibNamed("JFSideView", owner: nil, options: nil)?.last as! JFSideView
        sideView.layer.shadowOffset = CGSize(width: 2, height: 1)
        sideView.layer.shadowColor = UIColor.black.cgColor
        sideView.layer.shadowOpacity = 0.3
        sideView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 84, y: 0, width: 2, height: SCREEN_HEIGHT)).cgPath
        sideView.frame = CGRect(x: -86, y: 0, width: 85, height: SCREEN_HEIGHT)
        return sideView
    }
    
    /**
     显示侧边栏
     */
    func show() {
        UIApplication.shared.keyWindow?.addSubview(shadowButton)
        UIApplication.shared.keyWindow?.addSubview(self)
        
        self.alpha = 1
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(translationX: 86, y: 0)
            self.shadowButton.alpha = 0.1
            }, completion: { (_) in
                
        }) 
    }
    
    /**
     隐藏侧边栏
     */
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: { 
            self.transform = CGAffineTransform.identity
            self.alpha = 0
            self.shadowButton.alpha = 0
            }, completion: { (_) in
                self.removeFromSuperview()
                self.shadowButton.removeFromSuperview()
        }) 
    }
    
    /**
     点击了遮罩
     */
    @objc fileprivate func didTappedShadowButton(_ button: UIButton) {
        dismiss()
    }
    
    /**
     我的收藏
     */
    @IBAction func didTappedMyCollectionButton(_ sender: JFSideButton) {
        dismiss()
        delegate?.didTappedMyCollectionButton()
    }
    
    /**
     清理缓存
     */
    @IBAction func didTappedCleanCacheButton(_ sender: JFSideButton) {
        dismiss()
        delegate?.didTappedCleanCacheButton()
    }
    
    /**
     反馈
     */
    @IBAction func didTappedFeedbackButton(_ sender: JFSideButton) {
        dismiss()
        delegate?.didTappedFeedbackButton()
    }
    
    /**
     分享
     */
    @IBAction func didTappedShareButton(_ sender: JFSideButton) {
        dismiss()
        delegate?.didTappedShareButton()
    }

}
