//
//  UIButtonExtension.swift
//  NoCard
//
//  Created by zhoujianfeng on 2017/10/11.
//  Copyright © 2017年 zhoujianfeng. All rights reserved.
//

import Foundation

extension UIButton {
    
    /// 便捷构造按钮 点击事件
    ///
    /// - Parameters:
    ///   - target: 按钮点击监听对象
    ///   - action: 按钮点击事件
    convenience init(frame: CGRect, target: Any?, action: Selector?) {
        self.init(frame: frame)
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }
    
    /// 便捷构造按钮 带背景图片和点击事件
    ///
    /// - Parameters:
    ///   - bgImage: 背景图片名称
    ///   - target: 按钮点击监听对象
    ///   - action: 按钮点击事件
    convenience init(bgImage: String, target: Any?, action: Selector?) {
        self.init(frame: CGRect.zero, target: target, action: action)
        setBackgroundImage(UIImage(named: bgImage), for: .normal)
    }
    
    /// 便捷构造按钮 带图片和点击事件
    ///
    /// - Parameters:
    ///   - bgImage: 背景图片名称
    ///   - target: 按钮点击监听对象
    ///   - action: 按钮点击事件
    convenience init(image: String, target: Any?, action: Selector?) {
        self.init(frame: CGRect.zero, target: target, action: action)
        setImage(UIImage(named: image), for: .normal)
    }
    
    /// 便捷构造按钮
    ///
    /// - Parameters:
    ///   - text: 文本
    ///   - textColor: 文本颜色
    ///   - fontSize: 文本大小
    ///   - target: 按钮点击监听对象
    ///   - action: 按钮点击事件
    convenience init(text: String, textColor: UIColor, fontSize: CGFloat, target: Any? = nil, action: Selector? = nil) {
        self.init()
        
        setTitle(text, for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }
    
    /// 便捷构造按钮
    ///
    /// - Parameters:
    ///   - text: 文本
    ///   - textColor: 文本颜色
    ///   - fontSize: 文本大小
    ///   - image: 图标名称
    ///   - target: 按钮点击监听对象
    ///   - action: 按钮点击事件
    convenience init(text: String, textColor: UIColor, fontSize: CGFloat, image: String?, target: Any? = nil, action: Selector? = nil) {
        self.init()
        
        setTitle(text, for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
        if let image = image {
            setImage(UIImage(named: image), for: .normal)
        }
    }
}
