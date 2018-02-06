//
//  UIColorExtension.swift
//  EnglishCommunity-swift
//
//  Created by zhoujianfeng on 16/8/17.
//  Copyright © 2016年 zhoujianfeng. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// 16进制颜色值转UIColor
    ///
    /// - Parameters:
    ///   - hex: 16进制颜色值
    ///   - alpha: 透明度
    /// - Returns: UIColor
    class func hex(_ hex: String, alpha: CGFloat = 1.0) -> UIColor {
        
        var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if cString.count < 6 {
            return UIColor.black
        }
        if cString.hasPrefix("0X") {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))
        }
        if cString.hasPrefix("#") {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
        }
        if cString.count != 6 {
            return UIColor.black
        }
        
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: rString).scanHexInt32(&r)
        Scanner.init(string: gString).scanHexInt32(&g)
        Scanner.init(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
        
    }
}
