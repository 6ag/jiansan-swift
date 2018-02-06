//
//  JFAlertView.swift
//  NoCard
//
//  Created by mac on 2017/10/22.
//  Copyright © 2017年 zhoujianfeng. All rights reserved.
//

import UIKit

class JFAlertView: UIView {
    
    /// 提示文本
    fileprivate var message: String
    
    /// 确认按钮文字
    fileprivate var confirm: String?
    
    /// 取消按钮文字
    fileprivate var cancel: String?
    
    /// 确认按钮回调
    fileprivate var confirmClosure: (() -> Void)?
    
    /// 取消按钮回调
    fileprivate var cancelClosure: (() -> Void)?
    
    /// 是否可点击透明区域隐藏弹窗
    fileprivate var cancelable: Bool = true
    
    /// 创建自定义提示框
    ///
    /// - Parameters:
    ///   - message: 提示文本
    ///   - confirm: 确认按钮文字
    ///   - cancel: 取消按钮文字
    ///   - confirmClosure: 确认按钮回调
    ///   - cancelClosure: 取消按钮回调
    init(message: String, confirm: String? = "我知道了", cancel: String? = nil, cancelable: Bool = true, confirmClosure: (() -> Void)? = nil, cancelClosure: (() -> Void)? = nil) {
        self.message = message
        super.init(frame: SCREEN_BOUNDS)
        self.confirm = confirm
        self.cancel = cancel
        self.confirmClosure = confirmClosure
        self.cancelClosure = cancelClosure
        self.cancelable = cancelable
        
        messageLabel.text = message
        confirmButton.setTitle(confirm, for: .normal)
        cancelButton.setTitle(cancel, for: .normal)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 弹窗视图
    fileprivate lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    /// 提示文本
    fileprivate lazy var messageLabel: UILabel = {
        let label = UILabel(text: "", textColor: UIColor.hex("#282828"), fontSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    /// 确定
    fileprivate lazy var confirmButton: UIButton = {
        let button = UIButton(text: "", textColor: UIColor.hex("#ef5853"), fontSize: 15, target: self, action: #selector(didTappedConfirm))
        button.setBackgroundImage(UIImage.color(color: UIColor.white), for: .normal)
        button.setBackgroundImage(UIImage.color(color: UIColor.hex("#f5f7f9")), for: .highlighted)
        return button
    }()
    
    /// 取消
    fileprivate lazy var cancelButton: UIButton = {
        let button = UIButton(text: "", textColor: UIColor.lightGray, fontSize: 15, target: self, action: #selector(didTappedCancel))
        button.setBackgroundImage(UIImage.color(color: UIColor.white), for: .normal)
        button.setBackgroundImage(UIImage.color(color: UIColor.hex("#f5f7f9")), for: .highlighted)
        return button
    }()
    
}

// MARK: - UI
extension JFAlertView {
    
    fileprivate func setupUI() {
        
        if cancelable {
            addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedBgView)))
        }
        
        addSubview(containerView)
        containerView.addSubview(messageLabel)
        containerView.addSubview(confirmButton)
        containerView.addSubview(cancelButton)
        
        containerView.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.centerY.equalTo(self)
            make.height.equalTo(300) // 临时
        }
        
        messageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(30)
        }
        
        let lineView1 = UIView()
        lineView1.backgroundColor = UIColor.gray
        lineView1.alpha = 0.5
        containerView.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(messageLabel.snp.bottom).offset(30)
            make.height.equalTo(0.5)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(lineView1.snp.bottom)
            make.height.equalTo(40)
            if cancel?.isEmpty == false {
                make.width.equalTo((SCREEN_WIDTH - 50) * 0.5)
            } else {
                make.width.equalTo(0)
            }
        }
        
        let lineView2 = UIView()
        lineView2.backgroundColor = UIColor.gray
        lineView2.alpha = 0.5
        containerView.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.bottom)
            make.height.equalTo(40)
            make.centerX.equalTo(containerView)
            if cancel?.isEmpty == false {
                make.width.equalTo(0.5)
            } else {
                make.width.equalTo(0)
            }
        }
        
        confirmButton.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.top.equalTo(lineView1.snp.bottom)
            make.height.equalTo(40)
            if cancel?.isEmpty == false {
                make.width.equalTo((SCREEN_WIDTH - 50) * 0.5)
            } else {
                make.width.equalTo(SCREEN_WIDTH - 50)
            }
        }
        
        layoutIfNeeded()
        containerView.snp.updateConstraints { (make) in
            make.height.equalTo(confirmButton.frame.maxY)
        }
        
    }
}

// MARK: - Event
extension JFAlertView {
    
    @objc fileprivate func didTappedConfirm() {
        dismiss()
        confirmClosure?()
    }
    
    @objc fileprivate func didTappedCancel() {
        dismiss()
        cancelClosure?()
    }
    
    @objc fileprivate func didTappedBgView() {
        dismiss()
    }
    
}

// MARK: - 外界调用方法
extension JFAlertView {
    
    /// 弹出提示框
    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        backgroundColor = UIColor(white: 0, alpha: 0)
        alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.backgroundColor = UIColor(white: 0, alpha: 0.5)
            self.alpha = 1
        }
    }
    
    /// 隐藏提示框
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundColor = UIColor(white: 0, alpha: 0)
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
}
