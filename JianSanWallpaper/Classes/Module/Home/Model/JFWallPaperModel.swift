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
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    /**
     缓存大图
     
     - parameter bigpath: 大图路径
     */
    private class func bigImageCache(bigpath: String) {
        // 没有缓存才去缓存
        if !YYImageCache.sharedCache().containsImageForKey("\(BASE_URL)/\(bigpath)") {
            YYWebImageManager(cache: YYImageCache.sharedCache(), queue: NSOperationQueue()).requestImageWithURL(NSURL(string: "\(BASE_URL)/\(bigpath)")!, options: YYWebImageOptions.UseNSURLCache, progress: { (_, _) in
                }, transform: { (image, url) -> UIImage? in
                    return image
                }, completion: { (image, url, type, stage, error) in
            })
            print("\(bigpath) 首次缓存")
        } else {
            print("\(bigpath) 已经有缓存")
        }
        
    }
    
    /**
     从网络请求壁纸数据列表
     
     - parameter category_id: 壁纸分类id
     - parameter page:        分页页码
     - parameter finished:    数据回调
     */
    class func loadWallpapersFromNetwork(category_id: Int, page: Int, finished: (wallpaperArray: [JFWallPaperModel]?, error: NSError?) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "page" : page
        ]
        
        JFNetworkTools.shareNetworkTools.get(GET_WALLPAPERS(category_id), parameters: parameters) { (success, result, error) in
            
            guard let result = result where success == true else {
                finished(wallpaperArray: nil, error: error)
                return
            }
            
            var wallpaperArray = [JFWallPaperModel]()
            let data = result["data"].arrayObject as! [[String : AnyObject]]
            for dict in data {
                let wallpaper = JFWallPaperModel(dict: dict)
                self.bigImageCache(wallpaper.bigpath!)
                wallpaperArray.append(wallpaper)
            }
            
            finished(wallpaperArray: wallpaperArray, error: nil)
        }
    }
    
    /**
     从网络请求单个壁纸数据
     
     - parameter id:       壁纸id
     - parameter finished: 数据回调
     */
    class func showWallpaper(id: Int, finished: (wallpaper: JFWallPaperModel?, error: NSError?) -> ()) {
        
        JFNetworkTools.shareNetworkTools.get(GET_SHOW_WALLPAPER(id), parameters: [String : AnyObject]()) { (success, result, error) in
            guard let result = result where success == true else {
                finished(wallpaper: nil, error: error)
                return
            }
            
            let dict = result["data"].dictionaryObject!
            let wallpaper = JFWallPaperModel(dict: dict)
            finished(wallpaper: wallpaper, error: error)
            
        }
    }
    
}
