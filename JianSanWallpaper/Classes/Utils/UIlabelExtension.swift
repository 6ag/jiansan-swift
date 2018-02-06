//
//  UIlabelExtension.swift
//  NoCard
//
//  Created by zhoujianfeng on 2017/10/12.
//  Copyright © 2017年 zhoujianfeng. All rights reserved.
//

import Foundation

extension UILabel {
    
    /// 随便整一个Label
    ///
    /// - Parameters:
    ///   - text: 文本
    ///   - textColor: 文本颜色
    ///   - fontSize: 文本字体大小
    convenience init(text: String, textColor: UIColor, fontSize: CGFloat) {
        self.init()
        
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
    
}
