//
//  JFWallPaperModel.swift
//  JianSan Wallpaper
//
//  Created by zhoujianfeng on 16/4/26.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit
import SwiftyJSON
import YYWebImage

class JFWallPaperModel: NSObject {
    
    /// 壁纸id
    var id: Int = 0
    
    /// 壁纸分类
    var category_id: Int = 0
    
    /// 壁纸大图地址 需要自己拼接 BASE_URL
    var bigpath: String?
    
    /// 壁纸缩略图地址 需要自己拼接 BASE_URL
    var smallpath: String?
    
    /// 浏览量
    var view: Int = 0
    
    // 快速构造模型
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    /**
     从网络请求壁纸数据列表
     
     - parameter category_id: 壁纸分类id
     - parameter page:        分页页码
     - parameter finished:    数据回调
     */
    class func loadWallpapersFromNetwork(_ category_id: Int, page: Int, finished: @escaping (_ wallpaperArray: [JFWallPaperModel]?, _ error: NSError?) -> ()) {
        
        let parameters = [
            "page" : page
        ]
        
        JFNetworkTools.shareNetworkTools.get(GET_WALLPAPERS(category_id), parameters: parameters) { (success, result, error) in
            
            guard let result = result, success == true else {
                finished(nil, error)
                return
            }
            
            var wallpaperArray = [JFWallPaperModel]()
            let data = result["data"].arrayObject as! [[String : AnyObject]]
            for dict in data {
                let wallpaper = JFWallPaperModel(dict: dict)
                wallpaperArray.append(wallpaper)
            }
            
            finished(wallpaperArray, nil)
        }
    }
    
    /**
     从网络请求单个壁纸数据
     
     - parameter id:       壁纸id
     - parameter finished: 数据回调
     */
    class func showWallpaper(_ id: Int, finished: @escaping (_ wallpaper: JFWallPaperModel?, _ error: NSError?) -> ()) {
        
        JFNetworkTools.shareNetworkTools.get(GET_SHOW_WALLPAPER(id), parameters: [String : AnyObject]()) { (success, result, error) in
            guard let result = result, success == true else {
                finished(nil, error)
                return
            }
            
            let dict = result["data"].dictionaryObject!
            let wallpaper = JFWallPaperModel(dict: dict as [String : AnyObject])
            finished(wallpaper, error)
            
        }
    }
    
}
